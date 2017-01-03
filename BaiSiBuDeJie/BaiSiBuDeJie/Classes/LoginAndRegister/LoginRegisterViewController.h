//
//  LoginRegisterViewController.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/31.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShowType) {
    ShowTypeLogin, // defalut
    ShowTypeRigister
};
@interface LoginRegisterViewController : UIViewController
@property (nonatomic, assign) ShowType showType;
@end
