//
//  BSProgressHUD.m
//  BaiSiBuDeJie
//
//  Created by zhong on 17/1/6.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import "BSProgressHUD.h"
#import "SVProgressHUD.h"

@implementation BSProgressHUD

+ (void)initialize {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setCornerRadius:6.0];
}

+ (void)showNetworkError {
    [SVProgressHUD setMinimumSize:CGSizeMake(280, 100)];
    [SVProgressHUD showInfoWithStatus:@"当前网络不可用，请检查你的网络设置"];
    [SVProgressHUD dismissWithDelay:1.0];
}

+ (void)showToast:(NSString *)msg {
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showInfoWithStatus:msg];
}

+ (void)showToast:(NSString *)msg time:(NSTimeInterval)time {
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showInfoWithStatus:msg];
    [SVProgressHUD dismissWithDelay:time];
}

+ (void)showLoading:(NSString *)msg {
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showWithStatus:msg];
}

+ (void)showLoading:(NSString *)msg time:(NSTimeInterval)time {
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showWithStatus:msg];
    [SVProgressHUD dismissWithDelay:time];
}

+ (void)hideAllToast {
    [SVProgressHUD dismiss];
}

@end
