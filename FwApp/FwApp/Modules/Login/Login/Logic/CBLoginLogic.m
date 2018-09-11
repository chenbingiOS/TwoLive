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
#import "CBThirdLoginAPI.h"
#import "CBUserProfileLogic.h"
#import "CBTBC.h"
#import "CBUrlArgumentsFilter.h"

@implementation CBLoginLogic

// 环信登录
- (void)loginENClient {
//    [Bugly setUserIdentifier:[CBLiveUserConfig getHXuid]];
//    [[EMClient sharedClient] loginWithUsername:[CBLiveUserConfig getHXuid] password:[CBLiveUserConfig getHXpwd] completion:^(NSString *aUsername, EMError *aError) {
//        if (aError) {
//            NSLog(@"环信登录错误--%@",aError.errorDescription);
//        } else {
//            NSLog(@"环信登录成功--%@",aUsername);
//            [[EMClient sharedClient].options setIsAutoLogin:YES];
//            BOOL isAutoLogin = [EMClient sharedClient].isAutoLogin;
//            if (isAutoLogin) {
//                NSLog(@"自动登录");
//            } else {
//                NSLog(@"非自动登录");
//            }
//        }
//    }];
}

// 登录极光
- (void)loginJPUSH {
//    NSString *aliasStr = [NSString stringWithFormat:@"%@PUSH", [CBLiveUserConfig getOwnID]];
    //    [JPUSHService setAlias:aliasStr callbackSelector:nil object:nil];
}

// 本地UI登录
- (void)loginUI {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.45f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CBTBC *tbc = [CBTBC new];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = tbc;
    });
}

// 刷新用户用户信息
- (void)getUserProfileWithResponseObject:(id)responseObject {
    NSDictionary *rdata = responseObject[@"data"];
    NSString *token = rdata[@"token"];
    [CBUserProfileManager reloadUserProfileWithToken:token completionBlock:^{
        
        if ([CBUserProfileManager userProfile].token) {
            YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
            CBUrlArgumentsFilter *urlFilter = [CBUrlArgumentsFilter filterWithArguments:@{@"token": [CBUserProfileManager userProfile].token}];
            [config addUrlFilter:urlFilter];
        }
        
        [self loginENClient];
        [self loginJPUSH];
        [self loginUI];
    }];
}

// 登录
- (void)logicLoginWithUserName:(NSString *)userName
                   andPassword:(NSString *)password
               completionBlock:(CBNetworkCompletionBlock)completionBlock {
        
    CBLoginAPI *api = [[CBLoginAPI alloc] initWithUserName:userName andPassword:password];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (api.isSuccess) {
            
            [self getUserProfileWithResponseObject:request.responseObject];
            
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

// 注册
- (void)logicRegisterWithUserName:(NSString *)userName
                      andPassword:(NSString *)password
                          verCode:(NSString *)verCode
                  completionBlock:(CBNetworkCompletionBlock)completionBlock {
    
    if (userName.length == 0){
        [MBProgressHUD showAutoMessage:@"请输入手机号"];
        return;
    }
    if (userName.length != 11){
        [MBProgressHUD showAutoMessage:@"手机号输入错误"];
        return;
    }
    if (verCode.length == 0){
        [MBProgressHUD showAutoMessage:@"请输入验证码"];
        return;
    }
    if (password.length == 0){
        [MBProgressHUD showAutoMessage:@"请输入6-16位登录密码"];
        return;
    }
    
    CBRegisterAPI *api = [[CBRegisterAPI alloc] initWithUserName:userName andPassword:password verCode:verCode];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (api.isSuccess) {
            
            [self getUserProfileWithResponseObject:request.responseObject];
            
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

    if (userName.length != 11){
        [MBProgressHUD showAutoMessage:@"手机号输入错误"];
        return;
    }
    if (userName.length == 0){
        [MBProgressHUD showAutoMessage:@"请输入手机号"];
        return;
    }
    
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
    
    if (userName.length == 0){
        [MBProgressHUD showAutoMessage:@"请输入手机号"];
        return;
    }
    if (userName.length!=11){
        [MBProgressHUD showAutoMessage:@"手机号输入错误"];
        return;
    }
    if (verCode.length == 0){
        [MBProgressHUD showAutoMessage:@"请输入验证码"];
        return;
    }
    if (password.length == 0){
        [MBProgressHUD showAutoMessage:@"请输入6-16位登录密码"];
        return;
    }
    if (repassword.length == 0){
        [MBProgressHUD showAutoMessage:@"请输入6-16位登录密码"];
        return;
    }
    
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

// 第三方登录
- (void)logicThirdLoginWithParam:(NSDictionary *)param
                 completionBlock:(CBNetworkCompletionBlock)completionBlock {
    CBThirdLoginAPI *api = [[CBThirdLoginAPI alloc] initWithParam:param];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (api.isSuccess) {
            
            [self getUserProfileWithResponseObject:request.responseObject];
            
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
