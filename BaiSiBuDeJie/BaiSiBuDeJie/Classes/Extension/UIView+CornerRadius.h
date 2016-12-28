//
//  UIView+CornerRadius.h
//  Tools
//
//  Created by zhong on 16/11/17.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

@property (nonatomic, assign) CGFloat cornerRadius;

- (void)cornerRoundingCorners:(UIRectCorner)roundingCorners withCornerRadius:(CGFloat)cornerRadius;
@end
