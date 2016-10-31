//
//  CHDockView.h
//  团购
//
//  Created by chenwei on 16/9/16.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHDockView;

@protocol CHDockViewDelegate <NSObject>

- (void)dock:(CHDockView *)dock changeFrom:(NSInteger)from to:(NSInteger)to;

@end


@interface CHDockView : UIView

@property (nonatomic, weak) id<CHDockViewDelegate> delegate;

@end
