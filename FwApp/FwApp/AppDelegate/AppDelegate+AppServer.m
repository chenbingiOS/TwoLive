//
//  AppDelegate+AppServer.m
//  ProApp
//
//  Created by 陈冰 on 2018/4/4.
//  Copyright © 2018年 ChenBing. All rights reserved.
//

#import "AppDelegate+AppServer.h"
#import "CBTBC.h"
#import "CBNVC.h"
#import "CBGuideView.h"
#import "CBUrlArgumentsFilter.h"
#import "CBLoginVC.h"

@implementation AppDelegate (AppServer)

#pragma mark - 初始化 Window
- (void)_setup_Window {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

#pragma mark - rootVC
- (void)_setup_RootVC {
    if ([CBUserProfileManager userProfile].token) {
        self.rootVC = [CBTBC new];
        self.window.rootViewController = self.rootVC;
    } else{
        CBLoginVC *vc = [CBLoginVC new];
        CBNVC *navc = [[CBNVC alloc] initWithRootViewController:vc];
        self.window.rootViewController = navc;
    }
}

#pragma mark - 引导页面
- (void)_setup_Guide {
    NSMutableArray *images = [NSMutableArray new];
    if (iPhoneX) {
        [images addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_X1@3x" ofType:@"png"]]];
        [images addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_X2@3x" ofType:@"png"]]];
        [images addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_X3@3x" ofType:@"png"]]];
    } else {
        [images addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_1@3x" ofType:@"png"]]];
        [images addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_2@3x" ofType:@"png"]]];
        [images addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_3@3x" ofType:@"png"]]];
    }
    [[CBGuideView sharedInstance] showGuideViewWithImages:images
                        andButtonTitle:@"立即体验"
                   andButtonTitleColor:[UIColor whiteColor]
                      andButtonBGColor:[UIColor mainColor]
                  andButtonBorderColor:[UIColor clearColor]];
}

#pragma mark - 接口初始化
- (void)_setup_RequestAPI {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.debugLogEnabled = YES;
    config.baseUrl = @"http://fwtv.gttead.cn/";
    if ([CBUserProfileManager userProfile].token) {
        CBUrlArgumentsFilter *urlFilter = [CBUrlArgumentsFilter filterWithArguments:@{@"token": [CBUserProfileManager userProfile].token}];
        [config addUrlFilter:urlFilter];
    } 
}

//#pragma mark - 数据初始化
//- (void)initGiftData {
//    NSString *url = urlGetGiftOneList;
//    [PPNetworkHelper POST:url parameters:nil success:^(id responseObject) {
//        NSArray *giftAry = responseObject[@"data"];
//        if ([giftAry isKindOfClass:[NSArray class]]) {
//            for (NSString *urlString in giftAry) {
//                [[ArchiveManager manager] startRequest:urlString];
//            }
//        }
//    } failure:^(NSError *error) {
//    }];
//}

//#pragma mark - 七牛初始化
//- (void)initPLKit {
//    // 短视频
//    [PLShortVideoKitEnv initEnv];
//    //    [PLShortVideoKitEnv setLogLevel:PLShortVideoLogLevelDebug];
//    //    [PLShortVideoKitEnv enableFileLogging];
//    NSLog(@"短视频SDK版本 PLShortVideoKitEnv Version %f", PLShortVideoKitVersionNumber);
//
//
//    // 直播
//    [PLStreamingEnv initEnv];
//    [PLStreamingEnv setLogLevel:PLStreamLogLevelOff];
//    //    [PLStreamingEnv setLogLevel:PLStreamLogLevelDebug];
//    //    [PLStreamingEnv enableFileLogging];
//    NSLog(@"直播SDK版本 PLStreamingEnv Version %@", [PLMediaStreamingSession versionInfo]);
//}

//#pragma mark - 腾讯Bugly
//- (void)initTXBugly {
//    BuglyConfig *config = [[BuglyConfig alloc] init];
//    config.debugMode = YES;
//    config.blockMonitorEnable = YES;
//    config.blockMonitorTimeout = 1.5;
//    config.channel = @"Bugly";
//    config.delegate = self;
//    config.consolelogEnable = NO;
//    config.viewControllerTrackingEnable = NO;
//    [Bugly startWithAppId:@"8bbaef0e3e"
//#if DEBUG
//        developmentDevice:YES
//#endif
//                   config:config];
//
//    if ([CBLiveUserConfig getHXuid]) {
//        [Bugly setUserIdentifier:[CBLiveUserConfig getHXuid]];
//    }
//    NSLog(@"BuglySDK版本 Bugly version is %@", [Bugly sdkVersion]);
//}
//
//- (NSString * BLY_NULLABLE)attachmentForException:(NSException * BLY_NULLABLE)exception {
//    // {文件：行号 方法===崩溃原因}
//    NSLog(@"(%@:%d)----%s===%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, exception);
//    return @"This is an attachment";
//}


#pragma mark - 全局外观
- (void)_setup_Apperance {
    // 状态栏黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    // 导航栏
    [UINavigationBar appearance].translucent = NO;
    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor titleNormalColor]}];
    /*
     if (iPhoneX) {
     [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"jht_iphoenx"] imageWithRenderingMode:UIImageRenderingModeAutomatic] forBarMetrics:UIBarMetricsDefault];
     } else {
     [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"jht_sy_ztl"] imageWithRenderingMode:UIImageRenderingModeAutomatic] forBarMetrics:UIBarMetricsDefault];
     }
     */
    
    /*
     // 标签栏
     UIImage *tabBarBackground = [UIImage imageNamed:@"tabbar_bg"]; //需要的图片中包含黑线用作背景
     [[UITabBar appearance] setBackgroundImage:tabBarBackground];
     UIImage *tabBarShadow = [UIImage imageNamed:@"tabbar_bg_line"]; //需要的图片是一个1像素的透明图片
     [[UITabBar appearance] setShadowImage:tabBarShadow];
     */
    
    // 标签栏按钮
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    [textAttrs addEntriesFromDictionary:@{NSForegroundColorAttributeName : [UIColor titleNormalColor]}];
    [textAttrs addEntriesFromDictionary:@{NSFontAttributeName : [UIFont systemFontOfSize:11.0]}];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    [selectTextAttrs addEntriesFromDictionary:@{NSForegroundColorAttributeName : [UIColor titleSelectColor]}];
    [selectTextAttrs addEntriesFromDictionary:@{NSFontAttributeName : [UIFont systemFontOfSize:11.0]}];
    [item setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 按钮
    [[UIButton appearance] setExclusiveTouch:YES];  // 禁止按钮同时触发
    [[UIButton appearance] setShowsTouchWhenHighlighted:NO];   // 按钮被点击高亮提醒
    
    //    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = KWhiteColor;
    
    // iOS 11 ScrollView 偏移量
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    // TableView
    // 关闭Cell高度估算
    [UITableView appearance].estimatedRowHeight = 0;
    [UITableView appearance].estimatedSectionHeaderHeight = 0;
    [UITableView appearance].estimatedSectionFooterHeight = 0;
    // 关系cell点击效果
    [[UITableViewCell appearance] setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // 导航栏返回按钮
    [[UIBarButtonItem appearance] setTintColor:[UIColor backColor]];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"jht_dly_fh"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

@end

