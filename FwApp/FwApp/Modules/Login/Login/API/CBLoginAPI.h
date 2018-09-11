//
//  CBLoginAPI.h
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBRequestAPI.h"

@interface CBLoginAPI : CBRequestAPI

- (instancetype)initWithUserName:(NSString *)userName andPassword:(NSString *)password;

@end
