//
//  CHDealDropMenuView.m
//  团购
//
//  Created by chenwei on 16/9/19.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHDealDropMenuView.h"
#import "CHSubTitlesView.h"
#import "CHDealBaseItem.h"
#import "CHMetaDataTool.h"

#import "CHCategoryMenuItem.h"
#import "CHDistrictMenuItem.h"
#import "CHOrderMenuItem.h"

#define MENUDURATION        0.5
#define COVERALPHA          0.4

@interface CHDealDropMenuView ()
{
    UIView              *_cover;             // 蒙版
    UIView              *_contentView;       // 内容View，存放滚动视图和子菜单
    
    CHDealBaseItem      *_selectedItem;
}
@end

@implementation CHDealDropMenuView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        // 添加蒙版
        UIView *cover = [[UIView alloc] init];
        cover.alpha  = COVERALPHA;
        cover.frame = self.bounds;
        cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cover.backgroundColor = [UIColor blackColor];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
        [self addSubview:cover];
        _cover = cover;
        
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, 0, self.frame.size.width, DROPMENUHEIGHT);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_contentView];
        
        // 添加滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, DROPMENUHEIGHT);
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:scrollView];
        _scrollView = scrollView;
    }
    
    return self;
}

#pragma mark - 点击事件监听
- (void)itemClick:(CHDealBaseItem *)item
{
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    
    // 显示所有子标题
    if (item.titles.count > 0) {
        [self showSubTitleView:item.titles];
    } else {        // 没有子标题
        [self hideSubTitleView:item];
    }
}

#pragma mark - 子标题
#pragma mark 显示所有子标题
- (void)showSubTitleView:(NSArray *)titles
{
    if (_subTitlesView == nil) {
        _subTitlesView = [[CHSubTitlesView alloc] init];
//        [self setSubCategoryTitle];
        _subTitlesView.delegate = self;
    }
    _subTitlesView.frame = CGRectMake(0, DROPMENUHEIGHT, self.frame.size.width, _subTitlesView.frame.size.height);
    _subTitlesView.titles = titles;
    if (_subTitlesView.superview == nil) {
        [_subTitlesView subTitlesViewShow];
    }
    [_contentView insertSubview:_subTitlesView belowSubview:_scrollView];
    
    CGRect contentViewFrame = _contentView.frame;
    contentViewFrame.size.height = CGRectGetMaxY(_subTitlesView.frame);
    _contentView.frame = contentViewFrame;
}

#pragma mark 隐藏所有子标题
- (void)hideSubTitleView:(CHDealBaseItem *)item
{
    [_subTitlesView subTitlesViewHide];
    
    CGRect contentViewFrame = _contentView.frame;
    contentViewFrame.size.height = DROPMENUHEIGHT;
    _contentView.frame = contentViewFrame;
    
    NSString *title = [item titleForState:UIControlStateNormal];
    if ([item isKindOfClass:[CHCategoryMenuItem class]]) {
        [CHMetaDataTool sharedCHMetaDataTool].currentCategory = title;
    } else if ([item isKindOfClass:[CHDistrictMenuItem class]]) {
        [CHMetaDataTool sharedCHMetaDataTool].currentDistrict = title;
    } else {
        [CHMetaDataTool sharedCHMetaDataTool].currentOrder = [[CHMetaDataTool sharedCHMetaDataTool] orderModelWithName:title];
    }
}

#pragma mark - 动画
#pragma mark 动画形式显示
- (void)show
{
    _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
    _cover.alpha = 0;
    _contentView.alpha = 0;
    [UIView animateWithDuration:MENUDURATION animations:^{
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        _cover.alpha = COVERALPHA;
    }];
}

#pragma mark 动画形式隐藏
- (void)hide
{
    if (_hideBlock) {
        _hideBlock();
    }
    [UIView animateWithDuration:MENUDURATION animations:^{
        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
        _contentView.alpha = 0;
        _cover.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        _cover.alpha = COVERALPHA;
    }];
}

@end
