//
//  CHMoreItem.m
//  团购
//
//  Created by chenwei on 16/9/16.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHMoreItem.h"
#import "CHMoreViewController.h"
#import "CHNavigationController.h"

@implementation CHMoreItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        // 设置图片
        [self setNormalIcon:@"ic_more" selectIcon:@"ic_more_hl"];
        
        // 监听点击事件
        [self addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchDown];
    }
    
    return self;
}

#pragma mark - 更多按钮点击事件
- (void)moreClick
{
    self.enabled = NO;
    CHMoreViewController *moreViewController = [[CHMoreViewController alloc] init];
    moreViewController.moreItem = self;
    CHNavigationController *nav = [[CHNavigationController alloc] initWithRootViewController:moreViewController];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
