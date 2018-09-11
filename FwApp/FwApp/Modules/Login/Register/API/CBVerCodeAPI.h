//
//  CBVerCodeAPI.h
//  FwApp
//
//  Created by hxbjt on 2018/9/11.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBRequestAPI.h"

@interface CBVerCodeAPI : CBRequestAPI

- (instancetype)initWithUserName:(NSString *)userName
                       andStatus:(NSString *)status;

@end
