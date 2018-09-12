//
//  CBHomeVCUI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBHomeVCUI.h"
#import "CBHomeVC.h"
#import "CBAllVC.h"
#import "CBHotVC.h"
#import "CBTitleSelectView.h"

@interface CBHomeVCUI () <CBTitleSelectViewDelegate, UIScrollViewDelegate>

@end

@implementation CBHomeVCUI

- (void)_setup_UI {
    [self.ownerVC.view addSubview:self.selectedView];
    [self.ownerVC.view addSubview:self.scrollView];
    [self.ownerVC addChildViewController:self.hotVC];
    [self.ownerVC addChildViewController:self.allVC];
    [self.scrollView addSubview:self.hotVC.view];
    [self.scrollView addSubview:self.allVC.view];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat page = scrollView.contentOffset.x / kScreenWidth;
    [self.selectedView setSelectIndex:(NSInteger)(page+0.5)];
}

#pragma mark - CBTitleSelectViewDelegate

- (void)titleSelectView:(CBTitleSelectView *)view selectIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(index * kScreenWidth, 0) animated:YES];
}

#pragma mark - layz

- (CBTitleSelectView *)selectedView {
    if (!_selectedView) {
        _selectedView = [CBTitleSelectView viewFromXib];
        _selectedView.frame = CGRectMake(0, 0, kScreenWidth, SafeAreaNavHeight);
        _selectedView.delegate = self;
    }
    return _selectedView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGRect frame = CGRectMake(0, SafeAreaNavHeight, kScreenWidth, kScreenHeight-49-SafeAreaNavHeight-SafeAreaBottomHeight);
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (CBHotVC *)hotVC {
    if (!_hotVC) {
        _hotVC = [CBHotVC new];
        _hotVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-49-SafeAreaNavHeight-SafeAreaBottomHeight);
    }
    return _hotVC;
}

- (CBAllVC *)allVC {
    if (!_allVC) {
        _allVC = [CBAllVC new];
        _allVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-49-SafeAreaNavHeight-SafeAreaBottomHeight);
    }
    return _allVC;
}
@end
