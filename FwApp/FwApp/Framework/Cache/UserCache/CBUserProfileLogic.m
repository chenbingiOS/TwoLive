//
//  CBUserProfileLogic.m
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBUserProfileLogic.h"
#import "CBUserProfileVO.h"
// Tools
#import "CBArchiverTool.h"

static NSString * const kUserProfileConfigFilePath = @"kUserProfileConfigFilePath";
static NSString * const kUserProfileConfigKey = @"kUserProfileConfigKey";

@implementation CBUserProfileLogic

+ (CBUserProfileVO *)myProfile {
    return [CBArchiverTool unarchiverPath:kUserProfileConfigFilePath key:kUserProfileConfigKey];
}

+ (void)saveProfile:(CBUserProfileVO *)user {
    [CBArchiverTool archiverObject:user key:kUserProfileConfigKey filePath:kUserProfileConfigFilePath];
}

+ (void)clearProfile {
    [CBArchiverTool removeArchiverObjectFilePath:kUserProfileConfigFilePath];
}

@end
