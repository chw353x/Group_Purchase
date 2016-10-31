//
//  CHCategoryMenuItem.m
//  团购
//
//  Created by chenwei on 16/9/19.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHCategoryMenuItem.h"
#import "CHCategory.h"

#define kTitleScale     0.5

@implementation CHCategoryMenuItem

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    
    return self;
}

#pragma mark - 添加分类名称和图片
- (void)setCategory:(CHCategory *)category
{
    _category = category;
    
    // 分类名
    [self setTitle:category.name forState:UIControlStateNormal];
    // 图片
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
}

#pragma mark - 重新设置button中图片和文字的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height * kTitleScale;
    CGFloat y = contentRect.size.height - h;
    return CGRectMake(0, y, contentRect.size.width, h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return  CGRectMake(0, 4, contentRect.size.width, contentRect.size.height * (1-kTitleScale));
}

- (NSArray *)titles
{
    return _category.subCategories;
}

@end
