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

@end
