//
//  XZPagesController.h
//  XZPagesController
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZPagesControllerTopBar.h"

@interface XZPagesController : UIViewController
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) XZPagesControllerTopBar *topBar;
@property (nonatomic, assign) BOOL showToNavigationBar;
@property (nonatomic, assign) CGFloat topBarHeight;

@end
