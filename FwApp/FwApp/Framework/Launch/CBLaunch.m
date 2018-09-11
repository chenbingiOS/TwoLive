//
//  CBLaunch.m
//  FwApp
//
//  Created by hxbjt on 2018/9/7.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBLaunch.h"
#import "AppDelegate.h"
#import "AppDelegate+AppServer.h"

@implementation CBLaunch

DEF_SINGLETON(CBLaunch)

/**
 *  功能:window显示之前调用
 */
- (void)launchBeforeShowWindow {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate _setup_RequestAPI];
}

/**
 *  功能:window显示之后调用
 */
- (void)launchAfterShowWindow {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate _setup_Apperance];
    [appDelegate _setup_Guide];
}

/**
 *  功能:appbecame active使用
 */
- (void)launchBecomeActive {}

/**
 *  功能:从后台到前台
 */
- (void)launchAfterEnterForeground {}


@end
