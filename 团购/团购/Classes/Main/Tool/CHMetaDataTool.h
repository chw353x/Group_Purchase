//
//  CHMetaDataTool.h
//  团购
//
//  Created by chenwei on 16/9/18.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class CHCity, CHOrderModel;
@interface CHMetaDataTool : NSObject

singleton_interface(CHMetaDataTool)

@property (nonatomic, strong, readonly) NSArray *cityAllSections;           // 所有的城市组
@property (nonatomic, strong, readonly) NSDictionary *totalCities;          // 所有的城市

@property (nonatomic, strong) CHCity *currentCity;                          // 当前选中的城市
@property (nonatomic, copy) NSString *currentCategory;                      // 当前选中的分类
@property (nonatomic, copy) NSString *currentDistrict;                      // 当前选中的分区
@property (nonatomic, copy) CHOrderModel *currentOrder;                         // 当前选中的排序

@property (nonatomic, strong) NSArray *totalCategories;                     // 所有分类数据
@property (nonatomic, strong) NSArray *totalOrders;                         // 所有排序数据

// 根据排序名称返回排序对象
- (CHOrderModel *)orderModelWithName:(NSString *)name;
@end
