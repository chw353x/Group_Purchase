//
//  CHCity.m
//  团购
//
//  Created by chenwei on 16/9/18.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHCity.h"
#import "CHDistrict.h"
#import "NSObject+Value.h"

@implementation CHCity

- (void)setDistricts:(NSArray *)districts
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in districts) {
        CHDistrict *district = [[CHDistrict alloc] init];
        [district setValues:dict];
        [array addObject:district];
    }
    
    _districts = array;
}

@end
