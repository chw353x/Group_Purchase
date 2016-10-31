//
//  CHMineViewController.m
//  团购
//
//  Created by chenwei on 16/9/17.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHMineViewController.h"

@implementation CHMineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStyleBordered target:nil action:nil];
}

@end
