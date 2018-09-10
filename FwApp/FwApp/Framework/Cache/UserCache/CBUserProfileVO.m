//
//  CBUserProfileVO.m
//  ProApp
//
//  Created by hxbjt on 2018/5/23.
//  Copyright © 2018年 ChenBing. All rights reserved.
//

#import "CBUserProfileVO.h"
#import "NSObject+Coding.h"

@implementation CBUserProfileVO

DWObjectCodingImplmentation

DEF_SINGLETON(CBUserProfileVO)

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",
             @"token" : @"api_token"};
}

//- (void)reloadUserProfileWithNetwork {
//
//}

@end
