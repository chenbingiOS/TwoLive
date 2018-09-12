//
//  CBAppLiveAPI.h
//  FwApp
//
//  Created by hxbjt on 2018/9/12.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBRequestAPI.h"

@interface CBAppLiveAPI : CBRequestAPI

- (instancetype)initWithLiveType:(NSString *)liveType page:(NSString *)page;

@end
