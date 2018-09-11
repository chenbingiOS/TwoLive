//
//  CBRegisterAPI.h
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBRequestAPI.h"

@interface CBRegisterAPI : CBRequestAPI

- (instancetype)initWithUserName:(NSString *)userName
                     andPassword:(NSString *)password
                         verCode:(NSString *)verCode;

@end
