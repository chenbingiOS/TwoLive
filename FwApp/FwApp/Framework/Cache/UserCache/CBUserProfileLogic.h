//
//  CBUserProfileLogic.h
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBUserProfileVO;
@interface CBUserProfileLogic : NSObject

+ (CBUserProfileVO *)myProfile;
+ (void)saveProfile:(CBUserProfileVO *)user;
+ (void)clearProfile;

@end
