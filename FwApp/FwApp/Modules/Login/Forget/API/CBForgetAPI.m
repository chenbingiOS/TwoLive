//
//  CBForgetAPI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBForgetAPI.h"

@interface CBForgetAPI ()

@property (nonatomic, copy) NSString *mobile_num;
@property (nonatomic, copy) NSString *varcode;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *repassword;

@end

@implementation CBForgetAPI

- (NSString *)requestUrl {
    return @"Api/User/retrievePassword";
}

- (instancetype)initWithUserName:(NSString *)userName
                         verCode:(NSString *)verCode
                        password:(NSString *)password
                      repassword:(NSString *)repassword {
    if (self = [super init]) {
        _mobile_num = userName;
        _varcode = verCode;
        _password = password;
        _repassword = repassword;
    }
    return self;
}

@end
