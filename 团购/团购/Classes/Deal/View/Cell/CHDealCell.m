//
//  CHDealCell.m
//  团购
//
//  Created by chenwei on 16/9/24.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHDealCell.h"
#import "CHDeal.h"

@implementation CHDealCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDeal:(CHDeal *)deal
{
    _deal = deal;
    
    // 设置描述文字
    _desc.text = deal.desc;
    
    // 设置团购图片
    
}

@end
