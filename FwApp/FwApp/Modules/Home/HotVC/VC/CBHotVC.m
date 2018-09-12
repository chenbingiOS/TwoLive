//
//  CBHotVC.m
//  FwApp
//
//  Created by hxbjt on 2018/9/12.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBHotVC.h"
#import "CBHotVCUI.h"
#import "CBHotLogic.h"
#import "CBAppADCell.h"
#import "CBAppLiveCell.h"

#import <TYCyclePagerView/TYCyclePagerView.h>
#import <TYCyclePagerView/TYPageControl.h>

@interface CBHotVC () 

@property (nonatomic, strong) CBHotVCUI *ownerVCUI;
@property (nonatomic, strong) CBHotLogic *logic;

@end

@implementation CBHotVC

- (CBHotVCUI *)ownerVCUI {
    if (!_ownerVCUI) {
        _ownerVCUI = [CBHotVCUI new];
        _ownerVCUI.ownerVC = self;
    }
    return _ownerVCUI;
}

- (CBHotLogic *)logic {
    if (!_logic) {
        _logic = [CBHotLogic new];
    }
    return _logic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ownerVCUI _setup_UI];
}

- (void)http_GetLive {
    @weakify(self);
    [self.logic logicLiveWithType:@"1" page:@"1" completionBlock:^(id aResponseObject, NSError *error) {
        @strongify(self);
        [self.ownerVCUI.tableView.mj_header endRefreshing];
        [self.ownerVCUI.tableView reloadData];
    }];
}

- (void)http_GetAD {
    @weakify(self);
    [self.logic logicADWithCompletionBlock:^(id aResponseObject, NSError *error) {
        @strongify(self);
        self.ownerVCUI.pageControl.numberOfPages = self.logic.appADs.count;
        [self.ownerVCUI.cyclePagerView reloadData];
        [self.ownerVCUI.tableView reloadData];
    }];
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.logic.appADs.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    CBAppADCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:kReuseIdAppADCell forIndex:index];
    cell.appAdVO = self.logic.appADs[index];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc] init];
    //    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*0.884, CGRectGetHeight(pageView.frame)*0.92);
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*0.9, CGRectGetHeight(pageView.frame)*0.935);
    layout.itemSpacing = 4;
    layout.itemHorizontalCenter = YES;
    layout.layoutType = TYCyclePagerTransformLayoutNormal;
    return layout;
}

#pragma mark - TYCyclePagerViewDelegate

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self.ownerVCUI.pageControl.currentPage = toIndex;
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    
    //    if ([CBLiveUserConfig isNeedInvitationCode] && ![CBLiveUserConfig isCheck]) {
    //        [[CBInviteCodePopView sharePopView] showInviteView];
    //        return;
    //    }
    
    CBAppADVO *adVO = self.logic.appADs[index];
    //    if ([adVO.jump hasPrefix:@"http"]) {
    //        CBBannerADVC *vc = [CBBannerADVC new];
    //        [vc webViewloadRequestWithURLString:adVO.jump];
    //        [self.navigationController pushViewController:vc animated:YES];
    //    } else if (adVO.jump.numberValue) {
    //        [self httpGetRoom:adVO.jump];
    //    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logic.appLives.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (iPhoneX) {
        return kScreenWidth+5;
    } else {
        // 图片宽高修改
        return kScreenWidth*7/8+5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 直播格子
    CBAppLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdAppLiveCell];
    cell.live = self.logic.appLives[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    CBAppLiveVO *vo = self.logic.appLives[indexPath.row];
    //
    //    if ([CBLiveUserConfig isNeedInvitationCode] && ![CBLiveUserConfig isCheck]) {
    //        [[CBInviteCodePopView sharePopView] showInviteView];
    //        return;
    //    }
    //
    //    NSDictionary *param = @{@"token":[CBLiveUserConfig getOwnToken],
    //                            @"room_id": vo.room_id};
    //    NSString *url = urlIsAccessable;
    //    [PPNetworkHelper POST:url parameters:param success:^(id responseObject) {
    //        NSNumber *code = [responseObject valueForKey:@"code"];
    //        if ([code isEqualToNumber:@200]) {
    //            // 跳转直播播放器
    //            CBLiveVC *liveVC = [[CBLiveVC alloc] initWithLives:self.lives currentIndex:indexPath.row];
    //            @weakify(self);
    //            liveVC.reloadData = ^{
    //                @strongify(self);
    //                [self.tableView.mj_header beginRefreshing];
    //            };
    //            [self.navigationController pushViewController:liveVC animated:YES];
    //        } else {
    //            NSString *descrp = responseObject[@"descrp"];
    //            [MBProgressHUD showAutoMessage:descrp];
    //        }
    //    } failure:^(NSError *error) {
    //    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
