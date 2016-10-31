//
//  CHDealViewController.m
//  团购
//
//  Created by chenwei on 16/9/17.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHDealViewController.h"
#import "CHTopMenuView.h"
#import "DPRequest.h"
#import "DPAPI.h"
#import "CHMetaDataTool.h"
#import "CHCity.h"
#import "CHDeal.h"
#import "NSObject+Value.h"

#define kCollectionItemWidth    250

@interface CHDealViewController ()<DPRequestDelegate>
{
    NSMutableArray      *_deals;
}
@end

@implementation CHDealViewController

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kCollectionItemWidth, kCollectionItemWidth);     // 网格尺寸
    layout.minimumLineSpacing = 40.0f;          // 行距
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 监听城市改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kCityChangeNote object:nil];
    // 监听分类改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kCategoryChangeNote object:nil];
    // 监听分区改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kDistrictChangeNote object:nil];
    // 监听排序改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kOrderChangeNote object:nil];
    
    // 设置背景色
    self.collectionView.backgroundColor = kBackgroundColor;
    
    // 添加右边搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"请输入商品名、地址等";
    searchBar.frame = CGRectMake(0, 0, 200, 30);
    searchBar.barStyle = UIBarStyleBlack;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    
    CHTopMenuView *topMenu = [[CHTopMenuView alloc] init];
    topMenu.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topMenu];
    
    // 注册xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"CHDealCell" bundle:nil] forCellWithReuseIdentifier:@"DealCell"];
    
    // 设置collectionView永远支持垂直滚动
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    // 第一次加载的时候页面布局有问题，强制调用
    [self didRotateFromInterfaceOrientation:0];
}

#pragma mark - 控制器监听旋转（屏幕完成旋转的时候调用）
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    CGFloat V = 40.0f;
    CGFloat H = 0.0f;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) { // 横屏
        H = (self.view.frame.size.width - kCollectionItemWidth * 3)/4;
    } else {
        H = (self.view.frame.size.width - kCollectionItemWidth * 2)/3;  // 竖屏
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        layout.sectionInset = UIEdgeInsetsMake(V, H, V, H);
    }];
}

#pragma mark - 通知监听的方法
- (void)dataChange
{
    
    DPAPI *api= [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:@{
                @"city":[CHMetaDataTool sharedCHMetaDataTool].currentCity.name
                }
               delegate:self];
}

#pragma mark - DPRequestDelegate
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"%@", result);
    NSArray *array = [result objectForKey:@"deals"];
    
    _deals = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CHDeal *deal = [[CHDeal alloc] init];
        [deal setValues:dict];
        [_deals addObject:deal];
    }
    
    [self.collectionView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DealCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

@end
