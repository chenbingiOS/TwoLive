//
//  CBThirdLoginAPI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBThirdLoginAPI.h"

@interface CBThirdLoginAPI ()

@property (nonatomic, copy) NSDictionary *paramDict;

@end

@implementation CBThirdLoginAPI

- (NSString *)requestUrl {
    return @"Api/User/sendOauthUserInfo";
}

- (instancetype)initWithParam:(NSDictionary *)paramDict {
    self = [super init];
    if (self) {
        _paramDict = paramDict;
    }
    return self;
}

- (id)requestArgument {
    return _paramDict;
}

@end
