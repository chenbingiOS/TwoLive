//
//  CBLaunch.h
//  FwApp
//
//  Created by hxbjt on 2018/9/7.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBLaunch : NSObject

AS_SINGLETON(CBLaunch)

/**
 *  功能:window显示之前调用
 */
- (void)launchBeforeShowWindow;

/**
 *  功能:window显示之后调用
 */
- (void)launchAfterShowWindow;

/**
 *  功能:appbecame active使用
 */
- (void)launchBecomeActive;

/**
 *  功能:从后台到前台
 */
- (void)launchAfterEnterForeground;

@end
