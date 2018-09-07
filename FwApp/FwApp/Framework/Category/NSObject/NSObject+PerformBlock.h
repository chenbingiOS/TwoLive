//
//  NSObject+PerformBlock.h
//  OneStoreFramework
//
//  Created by Aimy on 14-6-28.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlock)

// try catch
- (NSException *)tryCatch:(void(^)(void))block;
- (NSException *)tryCatch:(void(^)(void))block finally:(void(^)(void))aFinisheBlock;

/**
 *  在主线程运行block
 *
 *  @param aInMainBlock 被运行的block
 */
- (void)performInMainThreadBlock:(void(^)(void))aInMainBlock;

/**
 *  延时在主线程运行block
 *
 *  @param aInMainBlock 被运行的block
 *  @param delay        延时时间
 */
- (void)performInMainThreadBlock:(void(^)(void))aInMainBlock afterSecond:(NSTimeInterval)delay;

/**
 *  在非主线程运行block
 *
 *  @param aInThreadBlock 被运行的block
 */
- (void)performInThreadBlock:(void(^)(void))aInThreadBlock;

/**
 *  延时在非主线程运行block
 *
 *  @param aInThreadBlock 被运行的block
 *  @param delay          延时时间
 */
- (void)performInThreadBlock:(void(^)(void))aInThreadBlock afterSecond:(NSTimeInterval)delay;

@end
