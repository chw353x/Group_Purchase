//
//  CHOrderMenuItem.h
//  团购
//
//  Created by chenwei on 16/9/20.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHDealBaseItem.h"

@class CHOrderModel;
@interface CHOrderMenuItem : CHDealBaseItem

@property (nonatomic, strong) CHOrderModel *order;

@end
