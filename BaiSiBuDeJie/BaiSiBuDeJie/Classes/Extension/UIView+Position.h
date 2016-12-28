//
//  UIView+Position.h
//  Tools
//
//  Created by zhong on 16/9/12.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Position)

@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat top; //y
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat left; //x
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;


@end
