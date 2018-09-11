//
//  CBLogic.h
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CBNetworkCompletionBlock)(id aResponseObject, NSError *error);

@interface CBLogic : NSObject

@property (nonatomic, copy) CBNetworkCompletionBlock completionBlock;

@end
