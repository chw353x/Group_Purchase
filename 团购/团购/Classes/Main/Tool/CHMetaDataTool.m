//
//  CHMetaDataTool.m
//  团购
//
//  Created by chenwei on 16/9/18.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHMetaDataTool.h"
#import "CHCitySection.h"
#import "NSObject+Value.h"
#import "CHCity.h"
#import "CHCategory.h"
#import "CHOrderModel.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.data"]

@interface CHMetaDataTool ()
{
    NSMutableArray *_visitedCityNames;      // 存储曾经访问过城市的名称
    NSMutableDictionary *_totalCities;      // 存放所有的城市 key 是城市名  value 是城市对象
    CHCitySection *_visitedSection;         // 最近访问的城市组数组
}
@end

@implementation CHMetaDataTool

singleton_implementation(CHMetaDataTool)

- (instancetype)init
{
    
    if (self = [super init]) {
        
        // 加载城市数据
        [self loadCityData];
        
        // 加载分类数据
        [self loadCategoriesData];
        
        // 加载所有排序数据
        [self loadOrderData];
    }
    return self;
}

#pragma mark - 加载元数据
#pragma mark 加载城市数据
- (void)loadCityData
{
    // 存放所有的城市
    _totalCities = [NSMutableDictionary dictionary];
    // 存放所有的城市组
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"plist"]];
    
    // 添加热门组
    CHCitySection *hotSections = [[CHCitySection alloc] init];
    hotSections.name = @"热门城市";
    // 存放所有的热门城市
    NSMutableArray *hotArray = [NSMutableArray array];
    hotSections.cities = hotArray;
    [tempArray addObject:hotSections];
    
    for (NSDictionary *dict in array) {
        CHCitySection *section = [[CHCitySection alloc] init];
        [section setValues:dict];
        [tempArray addObject:section];
        
        for (CHCity *city in section.cities) {
            if (city.hot) {
                [hotArray addObject:city];
            }
            
            [_totalCities setObject:city forKey:city.name];
        }
    }
    
    // 3.从沙盒中读取之前访问过的城市名称
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    // 4.添加最近访问城市组
    CHCitySection *visitedSection = [[CHCitySection alloc] init];
    visitedSection.name = @"最近访问";
    visitedSection.cities = [NSMutableArray array];
    _visitedSection = visitedSection;
    
    for (NSString *name in _visitedCityNames) {
        CHCity *city = _totalCities[name];
        [visitedSection.cities addObject:city];
    }
    
    if (_visitedSection.cities.count) {
        [tempArray insertObject:visitedSection atIndex:0];
    }
    
    _cityAllSections = tempArray;
}

#pragma mark 加载分类数据
- (void) loadCategoriesData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"]];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CHCategory *category = [[CHCategory alloc] init];
        [category setValues:dict];
        category.subCategories = [dict objectForKey:@"subcategories"];
        [temp addObject:category];
    }
    
    _totalCategories = temp;
}

#pragma mark 加载所有排序数据
- (void)loadOrderData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Orders" ofType:@"plist"]];
    
    NSMutableArray *temp = [NSMutableArray array];
    NSInteger count = array.count;
    for (int i = 0; i < count; i ++) {
        CHOrderModel *order = [[CHOrderModel alloc] init];
        order.name = array[i];
        order.index = i;
        [temp addObject:order];
    }
    
    _totalOrders = temp;
}

#pragma mark - 根据名称返回对象
- (CHOrderModel *)orderModelWithName:(NSString *)name
{
    for (CHOrderModel *order in _totalOrders) {
        if ([order.name isEqualToString:name]) {
            return order;
        }
    }
    return nil;
}

#pragma mark - 设置选中的数据
#pragma mark 设置当前选中的城市
- (void)setCurrentCity:(CHCity *)currentCity
{
    _currentCity = currentCity;
    
    // 移除之前的城市名
    [_visitedCityNames removeObject:currentCity.name];
    
    // 将新的城市名放到最前面
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    // 将新的城市放到_visitedSection的最前面
    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil];
    
    // 添加最近访问城市
    if (![_cityAllSections containsObject:_visitedSection]) {
        NSMutableArray *allSections = (NSMutableArray *)_cityAllSections;
        [allSections insertObject:_visitedSection atIndex:0];
    }
}

#pragma mark 设置当前选中的分类
- (void)setCurrentCategory:(NSString *)currentCategory
{
    _currentCategory = currentCategory;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryChangeNote object:nil];
}

#pragma mark 设置当前选中的区域
- (void)setCurrentDistrict:(NSString *)currentDistrict
{
    _currentDistrict = currentDistrict;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kDistrictChangeNote object:nil];
}

#pragma mark 设置当前选中的排序
- (void)setCurrentOrder:(CHOrderModel *)currentOrder
{
    _currentOrder = currentOrder;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderChangeNote object:nil];
}

@end
