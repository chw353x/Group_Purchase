//
//  CHDealCell.h
//  团购
//
//  Created by chenwei on 16/9/24.
//  Copyright © 2016年 yyjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHDeal;
@interface CHDealCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *desc;             // 描述

@property (weak, nonatomic) IBOutlet UIImageView *image;        // 图片

@property (weak, nonatomic) IBOutlet UILabel *price;            // 价格

@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;   // 购买人数

@property (weak, nonatomic) IBOutlet UIImageView *badge;        // 今日最新图标

@property (nonatomic, strong) CHDeal *deal;

@end
