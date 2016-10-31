//
//  CHTabItem.m
//  团购
//
//  Created by chenwei on 16/9/16.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHTabItem.h"

@implementation CHTabItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item"] forState:UIControlStateDisabled];
    }
    
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    _separator.hidden = !enabled;
    [super setEnabled:enabled];
}

@end
