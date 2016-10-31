//
//  CHTopMenuView.m
//  团购
//
//  Created by chenwei on 16/9/19.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHTopMenuView.h"
#import "CHTopMenuItem.h"
#import "CHCategoryMenu.h"
#import "CHDistrictMenu.h"
#import "CHOrderMenu.h"
#import "CHDealDropMenuView.h"
#import "CHMetaDataTool.h"
#import "CHOrderModel.h"

@interface CHTopMenuView ()
{
    CHTopMenuItem       *_selectedItem;
    CHCategoryMenu      *_categoryMenu;     // 分类
    CHDistrictMenu      *_districtMenu;     // 区域
    CHOrderMenu         *_orderMenu;        // 排序
    
    CHDealDropMenuView  *_showMenu;         // 当前显示的菜单
    
    CHTopMenuItem       *_categoryItem;
    CHTopMenuItem       *_districtItem;
    CHTopMenuItem       *_orderItem;
}
@end

@implementation CHTopMenuView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 全部分类
        _categoryItem = [self addTopMenuItem:@"全部分类" index:0];
        // 商区
        _districtItem = [self addTopMenuItem:@"全部商区" index:1];
        // 排序
        _orderItem = [self addTopMenuItem:@"默认排序" index:2];
        
        // 监听城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kCityChangeNote object:nil];
        // 监听分类改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kCategoryChangeNote object:nil];
        // 监听分区改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kDistrictChangeNote object:nil];
        // 监听排序改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:kOrderChangeNote object:nil];
    }
    
    return self;
}

#pragma mark - 通知调用方法
- (void)dataChange
{
    _selectedItem.selected = NO;
    _selectedItem = nil;
    
    if ([CHMetaDataTool sharedCHMetaDataTool].currentCategory) {
        _categoryItem.title = [CHMetaDataTool sharedCHMetaDataTool].currentCategory;
    }
    if ([CHMetaDataTool sharedCHMetaDataTool].currentDistrict) {
        _districtItem.title = [CHMetaDataTool sharedCHMetaDataTool].currentDistrict;
    }
    if ([CHMetaDataTool sharedCHMetaDataTool].currentOrder.name) {
        _orderItem.title = [CHMetaDataTool sharedCHMetaDataTool].currentOrder.name;
    }
    
    [_showMenu hide];
    _showMenu = nil;
}

#pragma mark - 添加顶部菜单项
- (CHTopMenuItem *)addTopMenuItem:(NSString *)title index:(NSInteger)index
{
    CHTopMenuItem *topItem = [[CHTopMenuItem alloc] init];
    topItem.title = title;
    topItem.frame = CGRectMake(TOPITEMWIDTH*index, 0, 0, 0);
    [topItem addTarget:self action:@selector(topItemClick:) forControlEvents:UIControlEventTouchUpInside];
    topItem.tag = index + 100;
    [self addSubview:topItem];
    return topItem;
}

#pragma mark - 初始化位置
- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(3 * TOPITEMWIDTH, TOPITEMHEIGHT);
    [super setFrame:frame];
}

#pragma mark - 顶部菜单点击事件
- (void)topItemClick:(CHTopMenuItem *)item
{
    _selectedItem.selected = NO;
    if (_selectedItem == item) {
        _selectedItem = nil;
        [self hiddenDropMenu];
    } else {
        item.selected = YES;
        _selectedItem = item;
        
        [self showDropMenu:item];
    }
}

#pragma mark - 显示底部菜单
- (void)showDropMenu:(CHTopMenuItem *)item
{
    BOOL animate = _showMenu == nil;
    // 移除当前显示的菜单
    [_showMenu removeFromSuperview];
    switch (item.tag) {
        case 100:
        {
            if (_categoryMenu == nil) {
                _categoryMenu = [[CHCategoryMenu alloc] init];
                _categoryMenu.frame = _contentView.bounds;
            }
            [_contentView addSubview:_categoryMenu];
            _showMenu = _categoryMenu;
        }
            break;
        case 101:
        {
            if (_districtMenu == nil) {
                _districtMenu = [[CHDistrictMenu alloc] init];
                _districtMenu.frame = _contentView.bounds;
            }
            [_contentView addSubview:_districtMenu];
            _showMenu = _districtMenu;
        }
            break;
        case 102:
        {
            if (_orderMenu == nil) {
                _orderMenu = [[CHOrderMenu alloc] init];
                _orderMenu.frame = _contentView.bounds;
            }
            [_contentView addSubview:_orderMenu];
            _showMenu = _orderMenu;
        }
            break;
        default:
            break;
    }
    
    __unsafe_unretained CHTopMenuView *menu = self;
    _showMenu.hideBlock = ^{
        menu->_selectedItem.selected = NO;
        menu->_selectedItem = nil;
        menu->_showMenu = nil;
    };
    
    if (animate) {
        [_showMenu show];
    }
}

#pragma mark - 隐藏底部菜单
- (void)hiddenDropMenu
{
    [_showMenu hide];
    _showMenu = nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
