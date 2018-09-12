//
//  CBHomeVCUI.h
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBHomeVC;
@class CBTitleSelectView;
@class CBHotVC;
@class CBAllVC;
@interface CBHomeVCUI : NSObject

@property (nonatomic, weak)   CBHomeVC *ownerVC;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CBTitleSelectView *selectedView;
@property (nonatomic, strong) CBHotVC *hotVC;
@property (nonatomic, strong) CBAllVC *allVC;

- (void)_setup_UI;

@end
