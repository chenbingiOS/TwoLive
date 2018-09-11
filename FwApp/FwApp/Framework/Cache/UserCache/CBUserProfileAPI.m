//
//  CBUserProfileAPI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBUserProfileAPI.h"

@interface CBUserProfileAPI ()

@property (nonatomic, copy) NSString *token;

@end

@implementation CBUserProfileAPI

- (instancetype)initWithToken:(NSString *)token {
    self = [super init];
    if (self) {
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Api/User/get_userinfo0";
}

//- (NSInteger)cacheTimeInSeconds {
//    return 60 * 3;
//}

@end
