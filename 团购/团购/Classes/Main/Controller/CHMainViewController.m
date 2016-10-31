//
//  CHMainViewController.m
//  团购
//
//  Created by chenwei on 16/9/16.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHMainViewController.h"
#import "CHDockView.h"
#import "CHDealViewController.h"
#import "CHCollectViewController.h"
#import "CHMapViewController.h"
#import "CHMineViewController.h"
#import "CHNavigationController.h"

@interface CHMainViewController ()<CHDockViewDelegate>
{
    UIView          *_contentView;
}
@end

@implementation CHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加dock
    CHDockView *dock = [[CHDockView alloc] init];
    dock.frame = CGRectMake(0, 0, 0, self.view.frame.size.height);
    dock.delegate = self;
    [self.view addSubview:dock];
    
    // 添加内容视图
    _contentView = [[UIView alloc] init];
    CGFloat w = self.view.frame.size.width - DOCKITEMWIDTH;
    CGFloat h = self.view.frame.size.height;
    _contentView.frame = CGRectMake(DOCKITEMWIDTH, 0, w, h);
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_contentView];
    // 添加所有子控制器
    [self addAllChildControllers];
}

#pragma mark - 添加所有子控制器
- (void)addAllChildControllers
{
    // 团购
    CHDealViewController *deal = [[CHDealViewController alloc] init];
    CHNavigationController *nav = [[CHNavigationController alloc] initWithRootViewController:deal];
    [self addChildViewController:nav];
    
    // 地图
    CHMapViewController *map = [[CHMapViewController alloc] init];
    map.view.backgroundColor = [UIColor grayColor];
    nav = [[CHNavigationController alloc] initWithRootViewController:map];
    [self addChildViewController:nav];
    
    // 收藏
    CHCollectViewController *collect = [[CHCollectViewController alloc] init];
    collect.view.backgroundColor = [UIColor greenColor];
    nav = [[CHNavigationController alloc] initWithRootViewController:collect];
    [self addChildViewController:nav];
    
    // 我的
    CHMineViewController *mine = [[CHMineViewController alloc] init];
    mine.view.backgroundColor = [UIColor blueColor];
    nav = [[CHNavigationController alloc] initWithRootViewController:mine];
    [self addChildViewController:nav];
    
    // 默认选中第一个
    [self dock:nil changeFrom:0 to:0];
}

- (void)dock:(CHDockView *)dock changeFrom:(NSInteger)from to:(NSInteger)to
{

    // 移除旧的
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    // 添加新的
    UIViewController *new = self.childViewControllers[to];
    new.view.frame = _contentView.bounds;
    new.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_contentView addSubview:new.view];
}

@end
