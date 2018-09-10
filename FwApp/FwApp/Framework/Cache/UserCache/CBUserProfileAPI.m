//
//  CBUserProfileAPI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBUserProfileAPI.h"

@implementation CBUserProfileAPI {
    NSString *_userId;
}

- (id)initWithUserId:(NSString *)userId {
    self = [super init];
    if (self) {
        _userId = userId;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Api/User/get_userinfo0";
}

- (id)requestArgument {
    return @{ @"id": _userId };
}

- (id)jsonValidator {
    return @{ @"nick": [NSString class],
              @"level": [NSNumber class] };
}

//- (NSInteger)cacheTimeInSeconds {
//    return 60 * 3;
//}

@end
