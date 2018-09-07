//
//  CBGuideViewCell.h
//  FwApp
//
//  Created by hxbjt on 2018/9/7.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenViewBounds [UIScreen mainScreen].bounds

static NSString * const kReuseIdGuideViewCell = @"kReuseIdGuideViewCell";

@interface CBGuideViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;

@end
