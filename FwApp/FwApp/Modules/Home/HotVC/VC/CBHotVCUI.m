//
//  CBHotVCUI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/12.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBHotVCUI.h"
#import "CBHotVC.h"
#import <TYCyclePagerView/TYCyclePagerView.h>
#import <TYCyclePagerView/TYPageControl.h>

@interface CBHotVC () <TYCyclePagerViewDataSource, TYCyclePagerViewDelegate, UITableViewDataSource, UITableViewDelegate>

- (void)http_GetLive;
- (void)http_GetAD;

@end

@interface CBHotVCUI ()

@property (nonatomic, strong) UIView *headerView;

@end

@implementation CBHotVCUI

- (void)_setup_UI {
    [self.headerView addSubview:self.cyclePagerView];
    [self.headerView addSubview:self.pageControl];
    self.tableView.tableHeaderView = self.headerView;
    [self.ownerVC.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)headerRereshing {
    [self.ownerVC http_GetLive];
    [self.ownerVC http_GetAD];
}

- (void)footerRereshing {
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - layz

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49-SafeAreaNavHeight-SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor bgColor];
        _tableView.scrollsToTop = YES;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self.ownerVC;
        _tableView.delegate = self.ownerVC;
        
        [_tableView registerNib:[UINib nibWithNibName:@"CBAppLiveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kReuseIdAppLiveCell];
        
        //头部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
        //底部刷新
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
        _tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    }
    return _tableView;
}

- (TYCyclePagerView *)cyclePagerView {
    if (!_cyclePagerView) {
        CGFloat height = kScreenWidth * 6 / 15;
        _cyclePagerView = [[TYCyclePagerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        _cyclePagerView.backgroundColor = [UIColor bgColor];
        _cyclePagerView.dataSource = self.ownerVC;
        _cyclePagerView.delegate = self.ownerVC;
        _cyclePagerView.autoScrollInterval = 4;
        _cyclePagerView.isInfiniteLoop = YES;
        
        [_cyclePagerView registerNib:[UINib nibWithNibName:@"CBAppADCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kReuseIdAppADCell];
    }
    return _cyclePagerView;
}

- (TYPageControl *)pageControl {
    if (!_pageControl) {
        CGFloat height = kScreenWidth * 6 / 15;
        _pageControl = [[TYPageControl alloc] initWithFrame:CGRectMake(0, height - 35, kScreenWidth, 26)];
        _pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    }
    return _pageControl;
}

- (UIView *)headerView {
    if (!_headerView) {
        CGFloat height = kScreenWidth * 6 / 15;
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height+60)];
        _headerView.backgroundColor = [UIColor bgColor];
    }
    return _headerView;
}

@end
