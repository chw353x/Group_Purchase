//
//  CHCitySection.m
//  团购
//
//  Created by chenwei on 16/9/18.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHCitySection.h"
#import "CHCity.h"
#import "NSObject+Value.h"

@implementation CHCitySection

- (void)setCities:(NSMutableArray *)cities
{
    id obj = [cities lastObject];
    if (![obj isKindOfClass:[NSDictionary class]]){
        _cities = cities;
        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in cities) {
        CHCity *city = [[CHCity alloc] init];
        [city setValues:dict];
        [array addObject:city];
    }
    _cities = array;
}

@end
