//
//  CBUserProfileLogic.m
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBUserProfileLogic.h"
#import "CBUserProfileAPI.h"

@implementation CBUserProfileLogic

// 用户信息
- (void)logicUserProfileWithToken:(NSString *)token
               completionBlock:(CBNetworkCompletionBlock)completionBlock {
    
    CBUserProfileAPI *api = [[CBUserProfileAPI alloc] initWithToken:token];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (completionBlock) {
            completionBlock(request.responseObject, nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
