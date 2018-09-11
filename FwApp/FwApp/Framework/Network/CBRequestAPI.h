//
//  CBRequestAPI.h
//  FwApp
//
//  Created by hxbjt on 2018/9/10.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork.h>

@interface CBRequestAPI : YTKRequest

//@property (nonatomic,assign) BOOL isOpenAES;    ///< 是否开启加密 默认关闭
@property (nonatomic, assign) BOOL isSuccess;    ///< 是否成功
@property (nonatomic, copy) NSString *code;     ///< 服务器返回的状态码
@property (nonatomic, copy) NSString *message;  ///< 服务器返回的信息

@end
