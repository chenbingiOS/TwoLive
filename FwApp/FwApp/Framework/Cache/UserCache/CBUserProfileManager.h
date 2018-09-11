//
//  CBUserProfileManager.h
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBUserProfileVO.h"

@interface CBUserProfileManager : NSObject

AS_SINGLETON(CBUserProfileManager)

+ (CBUserProfileVO *)userProfile;
+ (void)reloadUserProfileWithToken:(NSString *)token completionBlock:(void(^)(void))completionBlock;
+ (void)clearProfile;

@end
