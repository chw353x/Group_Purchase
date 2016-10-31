//
//  UIImage+CHW.m
//  团购
//
//  Created by chenwei on 16/9/17.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "UIImage+CHW.h"

@implementation UIImage (CHW)
#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}
@end
