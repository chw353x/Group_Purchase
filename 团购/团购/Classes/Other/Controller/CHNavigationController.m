//
//  CHNavigationController.m
//  团购
//
//  Created by chenwei on 16/9/17.
//  Copyright © 2016年 yyjz. All rights reserved.
//  自定义navigation

#import "CHNavigationController.h"
#import "UIImage+CHW.h"

@implementation CHNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

+ (void)initialize
{
    // 返回导航栏外观对象，修改此对象，相当于修改了整个项目中的外观
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 设置导航栏的背景图片
    [bar setBackgroundImage:[UIImage resizedImage:@"top-bar"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航栏文字主题
    [bar setTitleTextAttributes: @{UITextAttributeTextColor: [UIColor blackColor],
                                   UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]}];
    
    // 修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right_hl"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    // 修改item上的文字样式
    NSDictionary *dict = @{UITextAttributeTextColor: [UIColor darkGrayColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           UITextAttributeFont: [UIFont systemFontOfSize:16]};
    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    // 设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}

@end
