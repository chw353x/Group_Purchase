//
//  UIBarButtonItem+CHW.h
//  团购
//
//  Created by chenwei on 16/9/17.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CHW)
- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
@end
