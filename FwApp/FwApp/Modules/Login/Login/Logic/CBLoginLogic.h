//
//  CBLoginLogic.h
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBLogic.h"

@interface CBLoginLogic : CBLogic

// 登录
- (void)logicLoginWithUserName:(NSString *)userName
                   andPassword:(NSString *)password
               completionBlock:(CBNetworkCompletionBlock)completionBlock;
// 注册
- (void)logicRegisterWithUserName:(NSString *)userName
                      andPassword:(NSString *)password
                          verCode:(NSString *)verCode
                  completionBlock:(CBNetworkCompletionBlock)completionBlock;

// 验证码
- (void)logicVerCodeWithUserName:(NSString *)userName
                       andStatus:(NSString *)status
                 completionBlock:(CBNetworkCompletionBlock)completionBlock;

// 忘记密码
- (void)logicForgetWithUserName:(NSString *)userName
                        verCode:(NSString *)verCode
                       password:(NSString *)password
                     repassword:(NSString *)repassword
                completionBlock:(CBNetworkCompletionBlock)completionBlock;
@end
