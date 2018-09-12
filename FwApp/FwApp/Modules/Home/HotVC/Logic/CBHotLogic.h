//
//  CBHotLogic.h
//  FwApp
//
//  Created by hxbjt on 2018/9/12.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBLogic.h"

@interface CBHotLogic : CBLogic

@property (nonatomic, strong) NSArray *appLives;
@property (nonatomic, strong) NSArray *appADs;

// 直播列表 type 1热门 2全部 3附近
- (void)logicLiveWithType:(NSString *)liveType
                     page:(NSString *)page
          completionBlock:(CBNetworkCompletionBlock)completionBlock;

// 广告列表
- (void)logicADWithCompletionBlock:(CBNetworkCompletionBlock)completionBlock;

@end
