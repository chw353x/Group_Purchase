//
//  CHDockItem.h
//  团购
//
//  Created by chenwei on 16/9/16.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHDockItem : UIButton
{
    UIImageView *_separator;
}

@property (nonatomic, copy) NSString *normalIcon;
@property (nonatomic, copy) NSString *selectIcon;

// 设置按钮内部的图片
- (void)setNormalIcon:(NSString *)normalIcon selectIcon:(NSString *)selectIcon;
@end
