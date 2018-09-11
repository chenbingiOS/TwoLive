//
//  CBLoginLogic.m
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBLoginLogic.h"
#import "CBLoginAPI.h"
#import "CBRegisterAPI.h"

@implementation CBLoginLogic

// 登录
- (void)logicLoginWithUserName:(NSString *)userName
                   andPassword:(NSString *)password
               completionBlock:(CBNetworkCompletionBlock)completionBlock {
    CBLoginAPI *api = [[CBLoginAPI alloc] initWithUserName:userName andPassword:password];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completionBlock) {
            completionBlock(request.responseObject, nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

// 注册
- (void)logicRegisterWithUserName:(NSString *)userName
                      andPassword:(NSString *)password
                          verCode:(NSString *)verCode
                  completionBlock:(CBNetworkCompletionBlock)completionBlock {
    CBRegisterAPI *api = [[CBRegisterAPI alloc] initWithUserName:userName andPassword:password verCode:verCode];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completionBlock) {
            completionBlock(request.responseObject, nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
