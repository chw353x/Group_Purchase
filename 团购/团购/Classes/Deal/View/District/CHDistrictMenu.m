//
//  CHDistrictMenu.m
//  团购
//
//  Created by chenwei on 16/9/20.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHDistrictMenu.h"
#import "CHDistrictMenuItem.h"
#import "CHMetaDataTool.h"
#import "CHCity.h"
#import "CHDistrict.h"
#import "CHSubTitlesView.h"

@implementation CHDistrictMenu

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 向滚动视图添加item
        CHCity *currentCity = [CHMetaDataTool sharedCHMetaDataTool].currentCity;
        NSInteger count = [currentCity.districts count];
        
        for (int i = 0; i < count; i ++) {
            CHDistrictMenuItem *districtItem = [[CHDistrictMenuItem alloc] init];
            districtItem.district = currentCity.districts[i];
            districtItem.frame = CGRectMake(i * DROPMENUWIDTH, 0, 0, 0);
            [districtItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:districtItem];
        }
        _scrollView.contentSize = CGSizeMake(count * DROPMENUWIDTH, 0);
    }
    
    return self;
}

//- (void)setSubCategoryTitle
//{
//    _subTitlesView.setTitleBlock = ^(NSString *title)
//    {
//        [CHMetaDataTool sharedCHMetaDataTool].currentDistrict = title;
//    };
//    
//    _subTitlesView.getTitleBlock = ^{
//        return [CHMetaDataTool sharedCHMetaDataTool].currentDistrict;
//    };
//}

- (void)subTitleView:(CHSubTitlesView *)subTitleView titleClick:(NSString *)title
{
    [CHMetaDataTool sharedCHMetaDataTool].currentDistrict = title;
}

- (NSString *)subTitleViewGetCurrentTitle:(CHSubTitlesView *)subTitleView
{
    return [CHMetaDataTool sharedCHMetaDataTool].currentDistrict;
}

@end
