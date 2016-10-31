//
//  CHDockItem.m
//  团购
//
//  Created by chenwei on 16/9/16.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHDockItem.h"

@implementation CHDockItem

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 分割线
        UIImageView *separator = [[UIImageView alloc] init];
        separator.frame = CGRectMake(0, 0, DOCKITEMWIDTH, 2);
        separator.image = [UIImage imageNamed:@"separator_tabbar_item"];
        [self addSubview:separator];
        _separator = separator;
    }
    
    return self;
}

#pragma mark 宽高不可修改
- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(DOCKITEMWIDTH, DOCKITEMHEIGHT);
    [super setFrame:frame];
}

#pragma mark 取消高亮效果
- (void)setHighlighted:(BOOL)highlighted
{
    
}

#pragma mark - 设置按钮内部的图片
- (void)setNormalIcon:(NSString *)normalIcon
{
    _normalIcon = normalIcon;
    [self setImage:[UIImage imageNamed:normalIcon] forState:UIControlStateNormal];;
}

- (void)setSelectIcon:(NSString *)selectIcon
{
    _selectIcon = selectIcon;
    [self setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateDisabled];
}

- (void)setNormalIcon:(NSString *)normalIcon selectIcon:(NSString *)selectIcon
{
    self.normalIcon = normalIcon;
    self.selectIcon = selectIcon;
}

@end
