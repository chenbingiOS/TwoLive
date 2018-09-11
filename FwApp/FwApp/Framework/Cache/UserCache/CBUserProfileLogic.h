//
//  CBUserProfileLogic.h
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBLogic.h"

@class CBUserProfileVO;
@interface CBUserProfileLogic : CBLogic

- (void)logicUserProfileWithToken:(NSString *)token
                  completionBlock:(CBNetworkCompletionBlock)completionBlock;

@end
