//
//  AppDelegate+AppServer.h
//  ProApp
//
//  Created by 陈冰 on 2018/4/4.
//  Copyright © 2018年 ChenBing. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppServer)

/**
 设置 root Window
 */
- (void)_setup_Window;

/**
 设置 Window Root VC
 */
- (void)_setup_RootVC;

/**
 设置全局属性
 */
- (void)_setup_Apperance;

/**
 设置引导页面
 */
- (void)_setup_Guide;

/**
 网络初始化
 */
- (void)_setup_RequestAPI;

@end
