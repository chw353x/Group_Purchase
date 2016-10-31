//
//  CHCategory.h
//  团购
//
//  Created by chenwei on 16/9/19.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHCategory : CHBaseModel

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *subCategories;

@end
