//
//  CHTopMenuItem.m
//  团购
//
//  Created by chenwei on 16/9/19.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHTopMenuItem.h"

#define TITLESCALE      0.8

@implementation CHTopMenuItem

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 文字颜色
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 图片
        [self setImage:[UIImage imageNamed:@"ic_arrow_down"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 分割线
        UIImage *image = [UIImage imageNamed:@"separator_topbar_item"];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height/2);
        imageView.center = CGPointMake(TOPITEMWIDTH, TOPITEMHEIGHT/2);
        [self addSubview:imageView];
        
        [self setBackgroundImage:[UIImage imageNamed:@"bg_filter_toggle_hl"] forState:UIControlStateSelected];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(TOPITEMWIDTH, TOPITEMHEIGHT);
    [super setFrame:frame];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width * TITLESCALE, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * TITLESCALE, 0, contentRect.size.width * (1-TITLESCALE), contentRect.size.height);
}

@end
