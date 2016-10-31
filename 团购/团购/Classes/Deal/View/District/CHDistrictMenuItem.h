//
//  CHDistrictMenuItem.h
//  团购
//
//  Created by chenwei on 16/9/20.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHDealBaseItem.h"

@class CHDistrict;
@interface CHDistrictMenuItem : CHDealBaseItem

@property (nonatomic, strong) CHDistrict *district;         // 区域

@end
