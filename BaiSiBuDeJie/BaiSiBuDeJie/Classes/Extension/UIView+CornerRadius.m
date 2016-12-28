//
//  UIView+CornerRadius.m
//  Tools
//
//  Created by zhong on 16/11/17.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)
- (void)cornerRoundingCorners:(UIRectCorner)roundingCorners withCornerRadius:(CGFloat)cornerRadius {
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:roundingCorners
                                                         cornerRadii:cornerSize];
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    self.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    self.layer.mask = maskLayer;
    
    [self.layer setMasksToBounds:YES];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [self cornerRoundingCorners:UIRectCornerAllCorners withCornerRadius:cornerRadius];
}

- (CGFloat)cornerRadius {
    return self.cornerRadius;
}

@end
