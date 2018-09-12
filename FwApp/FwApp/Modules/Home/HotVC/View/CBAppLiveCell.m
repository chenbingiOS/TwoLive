//
//  CBAppLiveCell.m
//  MiaowShow
//
//  Created by ALin on 16/6/15.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "CBAppLiveCell.h"
#import "CBAppLiveVO.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+RoundedCorner.h"

@interface CBAppLiveCell()

@property (weak, nonatomic) IBOutlet UIView *liveStateView;     ///< 直播状态
@property (weak, nonatomic) IBOutlet UIImageView *bigPicView;   ///< 直播封面
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;///< 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;        ///< 昵称
@property (weak, nonatomic) IBOutlet UIImageView *startView;    ///< 等级
@property (weak, nonatomic) IBOutlet UILabel *roomIDLab;        ///< 房间号
@property (weak, nonatomic) IBOutlet UILabel *chaoyangLabel;    ///< 关注数量

@end

@implementation CBAppLiveCell

- (void)setLive:(CBAppLiveVO *)live
{
    _live = live;
    
    if (![live.channel_status isEqualToString:@"2"]) {
        self.liveStateView.hidden = YES;
    }
    [self.bigPicView sd_setImageWithURL:[NSURL URLWithString:live.thumb] placeholderImage:[UIImage imageNamed:@"home_empty"]];
    self.bigPicView.layer.masksToBounds = YES;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:live.avatar] placeholderImage:[UIImage imageNamed:@"placeholder_header_60"]];
    [self.headImageView roundedCornerByDefault];
    self.nameLabel.text = live.channel_title;
    self.nameLabel.text = live.user_nicename;
    NSString *rootIDAndName = [NSString stringWithFormat:@"房间号:%@", live.channel_stream];
    self.roomIDLab.text = rootIDAndName;
    self.startView.image  = [UIImage imageNamed:[NSString stringWithFormat:@"lv%@",live.host_level]];
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%ld人在看", live.online_num.integerValue];
    self.chaoyangLabel.text = fullChaoyang;
}

@end
