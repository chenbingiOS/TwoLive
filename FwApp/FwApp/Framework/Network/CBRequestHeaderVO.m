//
//  CBRequestHeaderVO.m
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBRequestHeaderVO.h"

@implementation CBRequestHeaderVO

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.userid = userManager.curUserInfo.userid;
//        self.imei = [OpenUDID value].length>32 ? [[OpenUDID value] substringToIndex:32] :[OpenUDID value];
//        self.clientId = self.imei;//[OpenUDID value].length>32 ? [[OpenUDID value] substringToIndex:32] :[OpenUDID value];
        self.os_type = @"2";
        self.channel = @"App Store";
        self.version = [UIApplication sharedApplication].appVersion;
        self.versioncode = [UIApplication sharedApplication].appBuildVersion;
        self.mobile_model = [UIDevice currentDevice].machineModelName;
        self.mobile_brand = [UIDevice currentDevice].machineModel;
    }
    return self;
}

@end
