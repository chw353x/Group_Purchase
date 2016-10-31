//
//  CHComment.h
//  团购
//
//  Created by chenwei on 16/9/16.
//  Copyright © 2016年 yyjz. All rights reserved.
//

// dockItem的宽高
#define DOCKITEMWIDTH  100
#define DOCKITEMHEIGHT 80

// 顶部菜单宽高
#define TOPITEMWIDTH    100
#define TOPITEMHEIGHT   44

// 分类宽高
#define DROPMENUWIDTH   100
#define DROPMENUHEIGHT  70

// 日志输出宏定义
#ifdef DEBUG
// 调试状态
#define NSLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define NSLog(...)
#endif

// 城市改变的通知
#define kCityChangeNote @"city_change"
// 分区改变的通知
#define kDistrictChangeNote @"district_change"
// 分类改变的通知
#define kCategoryChangeNote @"category_change"
// 排序改变的通知
#define kOrderChangeNote @"order_change"

// 控制器的背景色
#define kBackgroundColor [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal"]]
