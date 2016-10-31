//
//  CHCategoryMenu.m
//  团购
//
//  Created by chenwei on 16/9/19.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import "CHCategoryMenu.h"
#import "CHMetaDataTool.h"
#import "CHCategory.h"
#import "CHCategoryMenuItem.h"

#import "CHSubTitlesView.h"

@implementation CHCategoryMenu

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSArray *categories = [CHMetaDataTool sharedCHMetaDataTool].totalCategories;
        
        NSInteger count = categories.count;
        for (int i = 0; i < count; i ++) {
            
            // 向滚动视图中添加分类
            CHCategoryMenuItem *cateoryItem = [[CHCategoryMenuItem alloc] init];
            cateoryItem.category = categories[i];
            cateoryItem.frame = CGRectMake(i * DROPMENUWIDTH, 0, 0, 0);
            [cateoryItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:cateoryItem];
        }
        
        _scrollView.contentSize = CGSizeMake(count * DROPMENUWIDTH, 0);
    }
    
    return self;
}

//- (void)setSubCategoryTitle
//{
//    _subTitlesView.setTitleBlock = ^(NSString *title)
//    {
//        [CHMetaDataTool sharedCHMetaDataTool].currentCategory = title;
//    };
//    
//    _subTitlesView.getTitleBlock = ^{
//        return [CHMetaDataTool sharedCHMetaDataTool].currentCategory;
//    };
//}

- (void)subTitleView:(CHSubTitlesView *)subTitleView titleClick:(NSString *)title
{
    [CHMetaDataTool sharedCHMetaDataTool].currentCategory = title;
}

- (NSString *)subTitleViewGetCurrentTitle:(CHSubTitlesView *)subTitleView
{
    return [CHMetaDataTool sharedCHMetaDataTool].currentCategory;
}

@end
