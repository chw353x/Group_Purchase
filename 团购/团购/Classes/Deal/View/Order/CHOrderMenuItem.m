//
//  CHOrderMenuItem.m
//  团购
//
//  Created by chenwei on 16/9/20.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHOrderMenuItem.h"
#import "CHOrderModel.h"

@implementation CHOrderMenuItem

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)setOrder:(CHOrderModel *)order
{
    _order = order;
    [self setTitle:order.name forState:UIControlStateNormal];
}

@end
