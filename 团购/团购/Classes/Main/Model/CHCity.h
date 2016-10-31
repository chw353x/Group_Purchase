//
//  CHCity.h
//  团购
//
//  Created by chenwei on 16/9/18.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHCity : CHBaseModel

@property (nonatomic, strong) NSArray *districts;        // 分区
@property (nonatomic, assign) BOOL     hot;              // 是否是热门城市
@end
