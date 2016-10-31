//
//  CHSubTitles.h
//  团购
//
//  Created by chenwei on 16/9/20.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHSubTitlesView;
@protocol CHSubTitlesViewDelegate <NSObject>

- (void)subTitleView:(CHSubTitlesView *)subTitleView titleClick:(NSString *)title;
- (NSString *)subTitleViewGetCurrentTitle:(CHSubTitlesView *) subTitleView;

@end

@interface CHSubTitlesView: UIImageView

// block的实现方式
//@property (nonatomic, copy) void (^setTitleBlock)(NSString *title);
//@property (nonatomic, copy) NSString *(^getTitleBlock)();

@property (nonatomic, strong) NSArray *titles;          // 所有的子标题
@property (nonatomic, weak) id<CHSubTitlesViewDelegate> delegate;   // 代理实现方式

// 动画形式显示
- (void)subTitlesViewShow;
// 动画形式隐藏
- (void)subTitlesViewHide;
@end
