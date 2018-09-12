//
//  CBHotVCUI.h
//  FwApp
//
//  Created by hxbjt on 2018/9/12.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString * const kReuseIdAppLiveCell = @"kReuseIdAppLiveCell";
static NSString * const kReuseIdAppADCell = @"kReuseIdAppADCell";

@class CBHotVC;
@class TYCyclePagerView;
@class TYPageControl;
@interface CBHotVCUI : NSObject

@property (nonatomic, weak)   CBHotVC *ownerVC;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TYCyclePagerView *cyclePagerView;
@property (nonatomic, strong) TYPageControl *pageControl;

- (void)_setup_UI;

@end
