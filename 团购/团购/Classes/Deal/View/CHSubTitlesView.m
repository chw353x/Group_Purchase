//
//  CHSubTitles.m
//  团购
//
//  Created by chenwei on 16/9/20.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHSubTitlesView.h"
#import "UIImage+CHW.h"
#import "CHMetaDataTool.h"

#define kTitleWidth         100
#define kTitleHeight        40

#define MENUDURATION        0.5
#define COVERALPHA          1.0

@interface CHSubTitlesView ()
{
    UIButton            *_selectBtn;
}

@end

@implementation CHSubTitlesView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.image = [UIImage resizedImage:@"bg_subfilter_other"];
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    NSInteger count = titles.count;
    
    UIButton *btn = nil;
    for (int i = 0; i < count; i ++) {
        
        if (i >= self.subviews.count) {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_active"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        } else {
            btn = self.subviews[i];
        }
        
        btn.hidden = NO;
        // 
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        
//        if (_getTitleBlock) {
//            NSString *current = _getTitleBlock();
//            btn.selected = [titles[i] isEqualToString:current];
//        } else {
//            btn.selected = NO;
//        }

        if ([_delegate respondsToSelector:@selector(subTitleViewGetCurrentTitle:)]) {
            NSString *current = [_delegate subTitleViewGetCurrentTitle:self];
            btn.selected = [titles[i] isEqualToString:current];
            if (btn.selected) {
                _selectBtn = btn;
            }
        } else {
            btn.selected = NO;
        }
    }
    
    for (NSInteger i = count; i < self.subviews.count; i ++) {
        UIButton *btn = self.subviews[i];
        btn.hidden = YES;
    }
    
    [self layoutSubviews];
}

#pragma mark - 点击事件
- (void)titleClick:(UIButton *)btn
{
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    
    // 根据按钮文字决定要不要选中
//    if (_setTitleBlock) {
//        _setTitleBlock([btn titleForState:UIControlStateNormal]);
//    }
    
    if ([_delegate respondsToSelector:@selector(subTitleView:titleClick:)]) {
        [_delegate subTitleView:self titleClick:[btn titleForState:UIControlStateNormal]];
    }
}

#pragma mark - 自己宽高改变就会调用
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger columns = self.frame.size.width/kTitleWidth;
    for (int i = 0; i < _titles.count; i ++) {
        UIButton *btn = self.subviews[i];
        // 设置位置
        CGFloat x = i % columns * kTitleWidth;
        CGFloat y = i / columns * kTitleHeight;
        
        btn.frame = CGRectMake(x, y, kTitleWidth, kTitleHeight);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        NSInteger rows = (_titles.count + columns - 1) / columns;
        CGRect frame = self.frame;
        frame.size.height = rows * kTitleHeight + 10;
        self.frame = frame;
    }];
}

#pragma mark - 动画
#pragma mark 动画形式显示
- (void)subTitlesViewShow
{
    [self layoutSubviews];
    self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.alpha = 0;
    [UIView animateWithDuration:MENUDURATION animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = COVERALPHA;
    }];
}

#pragma mark 动画形式隐藏
- (void)subTitlesViewHide
{
    [UIView animateWithDuration:MENUDURATION animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.transform = CGAffineTransformIdentity;
        CGRect frame = self.frame;
        frame.size.height = 0;
        self.frame = frame;
        self.alpha = 1;
    }];
}

@end
