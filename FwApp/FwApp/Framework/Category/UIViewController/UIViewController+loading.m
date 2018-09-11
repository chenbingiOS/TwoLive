//
//  UIViewController+loading.m
//  OneStoreFramework
//
//  Created by Aimy on 14-7-30.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "UIViewController+loading.h"
#import "MBProgressHUD.h"

@implementation UIViewController (loading)

#pragma mark - loading

- (void)showLoading
{
    [self showLoadingWithMessage:nil];
}

- (void)showLoadingWithMessage:(NSString *)message
{
    [self showLoadingWithMessage:message hideAfter:0];
}

- (void)showLoadingWithMessage:(NSString *)message hideAfter:(NSTimeInterval)second
{
    [self showLoadingWithMessage:message onView:self.view hideAfter:second];
}

- (void)showLoadingWithMessage:(NSString *)message onView:(UIView *)aView hideAfter:(NSTimeInterval)second
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    
    if (message) {
        hud.label.text = message;
        hud.label.font = [UIFont systemFontOfSize:12];
        hud.mode = MBProgressHUDModeText;
    }
    else {
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    
    if (second > 0) {
        [hud hideAnimated:YES afterDelay:second];
    }
}

- (void)hideLoading
{
    [self hideLoadingOnView:self.view];
}

- (void)hideLoadingOnView:(UIView *)aView
{
    [MBProgressHUD hideHUDForView:aView animated:YES];
}

@end
