//
//  CHCategoryMenuItem.h
//  团购
//
//  Created by chenwei on 16/9/19.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHDealBaseItem.h"

@class CHCategory;
@interface CHCategoryMenuItem : CHDealBaseItem

@property (nonatomic, strong) CHCategory *category;         // 分类

@end
