//
//  CHDockView.m
//  团购
//
//  Created by chenwei on 16/9/16.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHDockView.h"
#import "CHMoreItem.h"
#import "CHLocationItem.h"
#import "CHTabItem.h"

@interface CHDockView ()
{
    CHTabItem           *_selectedTab;
}
@end

@implementation CHDockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置自动伸缩 宽度+右边距
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        
        // 设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar"]];
        
        // 添加logo
        [self addLogo];
        
        // 添加所有tab
        [self addAllTab];
        
        // 添加定位
        [self addLocaltion];
        // 添加跟多
        [self addMore];
    }
    
    return self;
}

#pragma mark - 初始化UI
#pragma mark 添加logo
- (void)addLogo
{
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"ic_logo"];
    CGFloat scale = 0.7;
    CGFloat logoW = logo.image.size.width * scale;
    CGFloat logoH = logo.image.size.height * scale;
    logo.frame = CGRectMake(0, 0, logoW, logoH);
    logo.center = CGPointMake(DOCKITEMWIDTH * 0.5, DOCKITEMHEIGHT * 0.5);
    [self addSubview:logo];
}

#pragma mark 添加跟多
- (void)addMore
{
    CHMoreItem *moreItem = [[CHMoreItem alloc] init];
    moreItem.frame = CGRectMake(0, self.frame.size.height - DOCKITEMHEIGHT, 0, 0);
//    moreItem.enabled = NO;
    [self addSubview:moreItem];
}

#pragma mark 添加定位
- (void)addLocaltion
{
    CHLocationItem *locationItem = [[CHLocationItem alloc] init];
    locationItem.frame = CGRectMake(0, self.frame.size.height - DOCKITEMHEIGHT * 2, 0, 0);
    //    locationItem.enabled = NO;
    [self addSubview:locationItem];
}

#pragma mark 添加所有tab
- (void)addAllTab
{
    // 团购
    [self addOneTab:@"ic_deal" selectIcon:@"ic_deal_hl" index:1];
    // 地图
    [self addOneTab:@"ic_map" selectIcon:@"ic_map_hl" index:2];
    // 收藏
    [self addOneTab:@"ic_collect" selectIcon:@"ic_collect_hl" index:3];
    // 我的
    [self addOneTab:@"ic_mine" selectIcon:@"ic_mine_hl" index:4];
    
    // 添加最后的一个分割线
    UIImageView *separator = [[UIImageView alloc] init];
    separator.frame = CGRectMake(0, DOCKITEMHEIGHT * 5, DOCKITEMWIDTH, 2);
    separator.image = [UIImage imageNamed:@"separator_tabbar_item"];
    [self addSubview:separator];
}

#pragma mark 添加一个tab
- (void)addOneTab:(NSString *)normalIcon selectIcon:(NSString *)selectIcon index:(NSInteger)index
{
    CHTabItem *tab = [[CHTabItem alloc] init];
    [tab setNormalIcon:normalIcon selectIcon:selectIcon];
    tab.frame = CGRectMake(0, DOCKITEMHEIGHT * index, 0, 0);
    [tab addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchDown];
    tab.tag = index - 1;
    [self addSubview:tab];
    
    if (index == 1) {
        [self tabClick:tab];
    }
}

#pragma mark - tab点击事件
- (void)tabClick:(CHTabItem *)tab
{
    if ([_delegate respondsToSelector:@selector(dock:changeFrom:to:)]) {
        [_delegate dock:self changeFrom:_selectedTab.tag to:tab.tag];
    }
    
    // 状态控制
    _selectedTab.enabled = YES;
    tab.enabled = NO;
    _selectedTab = tab;
}

#pragma mark - 防止更改宽度
- (void)setFrame:(CGRect)frame
{
    frame.size.width = DOCKITEMWIDTH;
    [super setFrame:frame];
}
@end
