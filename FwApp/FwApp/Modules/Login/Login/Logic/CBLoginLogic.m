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
#import "CBVerCodeAPI.h"
#import "CBForgetAPI.h"

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
        if (api.isSuccess) {
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

// 验证码
- (void)logicVerCodeWithUserName:(NSString *)userName
                       andStatus:(NSString *)status
                 completionBlock:(CBNetworkCompletionBlock)completionBlock {
    CBVerCodeAPI *api = [[CBVerCodeAPI alloc] initWithUserName:userName andStatus:status];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (api.isSuccess) {
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

// 忘记密码
- (void)logicForgetWithUserName:(NSString *)userName
                        verCode:(NSString *)verCode
                       password:(NSString *)password
                     repassword:(NSString *)repassword
                completionBlock:(CBNetworkCompletionBlock)completionBlock {
    CBForgetAPI *api = [[CBForgetAPI alloc] initWithUserName:userName verCode:verCode password:password repassword:repassword];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (api.isSuccess) {
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
