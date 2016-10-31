//
//  CHOrderMenu.m
//  团购
//
//  Created by chenwei on 16/9/20.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHOrderMenu.h"
#import "CHMetaDataTool.h"
#import "CHOrderModel.h"
#import "CHOrderMenuItem.h"

@implementation CHOrderMenu

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 给滚动视图中添加item
        NSArray *array = [CHMetaDataTool sharedCHMetaDataTool].totalOrders;
        NSInteger count = array.count;
        for (int i = 0; i < count; i ++) {
            CHOrderMenuItem *orderItem = [[CHOrderMenuItem alloc] init];
            orderItem.frame = CGRectMake(i * DROPMENUWIDTH, 0, 0, 0);
            orderItem.order = array[i];
            [orderItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:orderItem];
        }
        
        _scrollView.contentSize = CGSizeMake(count * DROPMENUWIDTH, 0);
    }
    return self;
}

@end
