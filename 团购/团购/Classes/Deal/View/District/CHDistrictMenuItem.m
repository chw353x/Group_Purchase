//
//  CHDistrictMenuItem.m
//  团购
//
//  Created by chenwei on 16/9/20.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHDistrictMenuItem.h"
#import "CHDistrict.h"

@implementation CHDistrictMenuItem

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return self;
}

- (void)setDistrict:(CHDistrict *)district
{
    _district = district;
    [self setTitle: district.name forState:UIControlStateNormal];
}

- (NSArray *)titles
{
    return _district.neighborhoods;
}

@end
