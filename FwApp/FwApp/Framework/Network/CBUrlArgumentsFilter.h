//
//  CBUrlArgumentsFilter.h
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork.h>

@interface CBUrlArgumentsFilter : NSObject <YTKUrlFilterProtocol>

+ (CBUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;

@end
