//
//  CHDealDropMenuView.h
//  团购
//
//  Created by chenwei on 16/9/19.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHSubTitlesView;
@protocol CHSubTitlesViewDelegate;
@interface CHDealDropMenuView : UIView<CHSubTitlesViewDelegate>
{
    UIScrollView        *_scrollView;
    CHSubTitlesView     *_subTitlesView;      // 子菜单
}

@property (nonatomic, copy) void (^hideBlock)();

// 动画形式显示
- (void)show;
// 动画形式隐藏
- (void)hide;

//- (void)setSubCategoryTitle;
@end
