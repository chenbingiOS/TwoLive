//
//  CBHotLogic.m
//  FwApp
//
//  Created by hxbjt on 2018/9/12.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBHotLogic.h"
#import "CBAppLiveAPI.h"
#import "CBAppADAPI.h"
#import "CBAppADVO.h"
#import "CBAppLiveVO.h"

@implementation CBHotLogic

- (void)logicLiveWithType:(NSString *)liveType
                     page:(NSString *)page
          completionBlock:(CBNetworkCompletionBlock)completionBlock {
    
    CBAppLiveAPI *api = [[CBAppLiveAPI alloc] initWithLiveType:liveType page:page];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (api.isSuccess) {

            self.appLives= [NSArray modelArrayWithClass:[CBAppLiveVO class] json:request.responseObject[@"data"]];

            completionBlock(request.responseObject, nil);
        } else {
            NSError *error = [NSError errorWithDomain:api.message code:api.code.integerValue userInfo:nil];
            completionBlock(nil, error);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completionBlock) {
            completionBlock(nil, request.error);
        }
    }];
}

- (void)logicADWithCompletionBlock:(CBNetworkCompletionBlock)completionBlock {
    
    CBAppADAPI *api = [[CBAppADAPI alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (api.isSuccess) {

            self.appADs = [NSArray modelArrayWithClass:[CBAppADVO class] json:request.responseObject[@"data"]];

            completionBlock(request.responseObject, nil);
        } else {
            NSError *error = [NSError errorWithDomain:api.message code:api.code.integerValue userInfo:nil];
            completionBlock(nil, error);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completionBlock) {
            completionBlock(nil, request.error);
        }
    }];
}

@end
