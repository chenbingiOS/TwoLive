//
//  CBLoginAPI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBLoginAPI.h"

@interface CBLoginAPI ()

@property (nonatomic, copy) NSString *mobile_num;
@property (nonatomic, copy) NSString *password;

@end

@implementation CBLoginAPI

- (NSString *)requestUrl {
    return @"Api/User/login";
}

- (instancetype)initWithUserName:(NSString *)userName andPassword:(NSString *)password {
    if (self = [super init]) {
        _mobile_num = userName;
        _password = password;
    }
    return self;
}

@end
