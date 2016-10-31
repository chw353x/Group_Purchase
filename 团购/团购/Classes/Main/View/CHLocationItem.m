//
//  CHLocationItem.m
//  团购
//
//  Created by chenwei on 16/9/16.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHLocationItem.h"
#import "CHCityListViewController.h"
#import "CHCity.h"
#import "CHMetaDataTool.h"

@interface CHLocationItem ()<UIPopoverControllerDelegate>
{
    UIPopoverController *_popView;
}
@end

@implementation CHLocationItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        // 设置图片
        [self setNormalIcon:@"ic_district" selectIcon:@"ic_district_hl"];
        
        // 设置文字
        [self setTitle:@"定位中" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 设置图片属性
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 添加点击事件
        [self addTarget:self action:@selector(localtionClick) forControlEvents:UIControlEventTouchDown];
    
    }
    
    return self;
}

#pragma mark - 设置按钮中图片和文字的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * 0.5;
    return CGRectMake(0, 4, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * 0.45;
    CGFloat y = contentRect.size.height - h;
    return CGRectMake(0, y, w, h);
}

#pragma mark - 点位点击事件
- (void)localtionClick
{
    self.enabled = NO;
    CHCityListViewController *cityList = [[CHCityListViewController alloc] init];
    _popView = [[UIPopoverController alloc] initWithContentViewController:cityList];
    _popView.popoverContentSize = CGSizeMake(320, 480);
    _popView.delegate = self;
    _popView.backgroundColor = [UIColor blackColor];
    [self showPopover];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 监听屏幕旋转通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    // 监听城市改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
}

#pragma mark - 屏幕旋转事件监听
- (void)screenRotate
{
    if (_popView.popoverVisible) {
        [_popView dismissPopoverAnimated:NO];
        
        [self performSelector:@selector(showPopover) withObject:nil afterDelay:0.5f];
    }
}

#pragma mark - 显示popover
- (void)showPopover
{
    [_popView presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - 城市改变
- (void)cityChange
{
    CHCity *city = [CHMetaDataTool sharedCHMetaDataTool].currentCity;
    
    // 更改显示的城市名称
    [self setTitle:city.name forState:UIControlStateNormal];
    
    // 关闭popover（代码关闭popover不会触发代理方法）
    [_popView dismissPopoverAnimated:YES];
    
    // 变为enable
    self.enabled = YES;
}

#pragma mark - popoverController delegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    // 变为enable
    self.enabled = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
