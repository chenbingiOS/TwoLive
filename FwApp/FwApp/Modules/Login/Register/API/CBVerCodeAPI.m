//
//  CBVerCodeAPI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBVerCodeAPI.h"

@interface CBVerCodeAPI ()

@property (nonatomic, copy) NSString *mobile_num;
@property (nonatomic, copy) NSString *status;

@end

@implementation CBVerCodeAPI

- (NSString *)requestUrl {
    return @"Api/User/get_phone_varcode";
}

- (instancetype)initWithUserName:(NSString *)userName
                       andStatus:(NSString *)status {
    if (self = [super init]) {
        _mobile_num = userName;
        _status = status;
    }
    return self;
}

@end
