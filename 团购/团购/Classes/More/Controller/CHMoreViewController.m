//
//  CHMoreViewController.m
//  团购
//
//  Created by chenwei on 16/9/17.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHMoreViewController.h"

@implementation CHMoreViewController

- (void)viewDidLoad
{
    self.title = @"更多";
    // 导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    // 导航栏右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"意见反馈" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - 导航栏上的按钮点击事件
#pragma mark 导航栏左侧完成按钮点击事件
- (void)done
{
    [self dismissViewControllerAnimated:YES completion:^{
        _moreItem.enabled = YES;
    }];
}

@end
