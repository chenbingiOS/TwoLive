//
//  CBFuncDefine.h
//  FwApp
//
//  Created by hxbjt on 2018/9/7.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#ifndef CBFuncDefine_h
#define CBFuncDefine_h

// 日志
#ifdef DEBUG
#define NSLog(format, ...) printf("Class: <%p %s:(%d)> Method: %s\n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define NSLog(format, ...)
#endif

// 判断是否iPhoneX YES:iPhoneX屏幕 NO:传统屏幕
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 安全区域
#define SafeAreaTopHeight (iPhoneX ? 44 : 20)
#define SafeAreaNavHeight (iPhoneX ? 88 : 64)
#define SafeAreaBottomHeight (iPhoneX ? 34 : 0)

// 单例
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#endif /* CBFuncDefine_h */
