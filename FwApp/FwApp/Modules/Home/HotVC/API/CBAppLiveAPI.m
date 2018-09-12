//
//  CBAppLiveAPI.m
//  FwApp
//
//  Created by hxbjt on 2018/9/12.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBAppLiveAPI.h"

@interface CBAppLiveAPI ()

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *page;

@end

@implementation CBAppLiveAPI

- (NSString *)requestUrl {
    return @"Api/Anchor/getLive";
}

- (instancetype)initWithLiveType:(NSString *)liveType page:(NSString *)page {
    if (self = [super init]) {
        _type = liveType;
        if (page == nil) {
            page = @"0";
        }
        _page = page;
    }
    return self;
}

@end
