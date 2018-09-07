//
//  CBGuideViewCell.m
//  FwApp
//
//  Created by hxbjt on 2018/9/7.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBGuideViewCell.h"

@implementation CBGuideViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.layer.masksToBounds = YES;
    self.imageView = [[UIImageView alloc] initWithFrame:kScreenViewBounds];
    self.imageView.center = CGPointMake(kScreenViewBounds.size.width / 2, kScreenViewBounds.size.height / 2);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.hidden = YES;
    [button setFrame:CGRectMake(0, 0, 200, 44)];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.layer setCornerRadius:22];
    [button.layer setBorderColor:[UIColor grayColor].CGColor];
    [button.layer setBorderWidth:1.0f];
    [button setBackgroundColor:[UIColor whiteColor]];
    self.button = button;
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.button];
    if (iPhoneX) {
        [self.button setCenter:CGPointMake(kScreenViewBounds.size.width / 2, kScreenViewBounds.size.height-140+22)];
    } else {
        [self.button setCenter:CGPointMake(kScreenViewBounds.size.width / 2, kScreenViewBounds.size.height-98+22)];
    }
}

@end
