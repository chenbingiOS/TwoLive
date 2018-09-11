//
//  CBRegisterAPI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBRegisterAPI.h"

@interface CBRegisterAPI ()

@property (nonatomic, copy) NSString *mobile_num;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *varcode;

@end

@implementation CBRegisterAPI

- (NSString *)requestUrl {
    return @"Api/User/register";
}

- (instancetype)initWithUserName:(NSString *)userName
                     andPassword:(NSString *)password
                         verCode:(NSString *)verCode {
    if (self = [super init]) {
        _mobile_num = userName;
        _password = password;
        _varcode = verCode;
    }
    return self;
}

@end
