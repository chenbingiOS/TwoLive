//
//  CBForgetAPI.h
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBRequestAPI.h"

@interface CBForgetAPI : CBRequestAPI

- (instancetype)initWithUserName:(NSString *)userName
                         verCode:(NSString *)verCode
                        password:(NSString *)password
                      repassword:(NSString *)repassword;

@end
