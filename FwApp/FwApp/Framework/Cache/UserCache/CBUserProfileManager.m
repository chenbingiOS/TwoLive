//
//  CBUserProfileManager.m
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBUserProfileManager.h"
#import "CBUserProfileLogic.h"
#import "CBUserProfileVO.h"
// Tools
#import "CBArchiverTool.h"

static NSString * const kUserProfileConfigFilePath = @"kUserProfileConfigFilePath";
static NSString * const kUserProfileConfigKey = @"kUserProfileConfigKey";

@interface CBUserProfileManager ()

@property (nonatomic, strong) CBUserProfileLogic *logic;
@property (nonatomic, strong) CBUserProfileVO *userProfileVO;

@end

@implementation CBUserProfileManager

DEF_SINGLETON(CBUserProfileManager)

+ (CBUserProfileVO *)userProfile {
    
    if ([CBUserProfileManager sharedInstance].userProfileVO == nil) {
        [CBUserProfileManager sharedInstance].userProfileVO = [self myProfile];
    }
    
    return [CBUserProfileManager sharedInstance].userProfileVO;
}

+ (CBUserProfileVO *)myProfile {
    return [CBArchiverTool unarchiverPath:kUserProfileConfigFilePath key:kUserProfileConfigKey];
}

+ (void)saveProfile:(CBUserProfileVO *)user {
    [CBArchiverTool archiverObject:user key:kUserProfileConfigKey filePath:kUserProfileConfigFilePath];
}

+ (void)clearProfile {
    [CBArchiverTool removeArchiverObjectFilePath:kUserProfileConfigFilePath];
}

+ (void)reloadUserProfileWithToken:(NSString *)token completionBlock:(void(^)(void))completionBlock {
    if (token == nil) {
        token = [CBUserProfileManager userProfile].token;
    }
    
    [[CBUserProfileManager sharedInstance].logic logicUserProfileWithToken:token completionBlock:^(id aResponseObject, NSError *error) {
        CBUserProfileVO *vo = [CBUserProfileVO modelWithJSON:aResponseObject];
        [CBUserProfileManager saveProfile:vo];
        [CBUserProfileManager sharedInstance].userProfileVO = vo;
        
        if (completionBlock) {
            completionBlock();
        }
    }];
}

@end
