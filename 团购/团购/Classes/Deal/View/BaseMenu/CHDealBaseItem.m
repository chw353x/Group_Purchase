//
//  CHDealBaseItem.m
//  团购
//
//  Created by chenwei on 16/9/20.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHDealBaseItem.h"
#import "UIImage+CHW.h"

@interface CHDealBaseItem ()
{
    
}
@end

@implementation CHDealBaseItem

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 分割线
        UIImage *image = [UIImage imageNamed:@"separator_filter_item"];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height/3);
        imageView.center = CGPointMake(DROPMENUWIDTH, DROPMENUHEIGHT/2);
        [self addSubview:imageView];

        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage resizedImage:@"bg_filter_toggle_hl"] forState:UIControlStateSelected];
    }
    
    return self;
}

#pragma mark - 重写方法，给定每个分类按钮的宽高
- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(DROPMENUWIDTH, DROPMENUHEIGHT);
    [super setFrame:frame];
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (NSArray *)titles
{
    return nil;
}
@end
