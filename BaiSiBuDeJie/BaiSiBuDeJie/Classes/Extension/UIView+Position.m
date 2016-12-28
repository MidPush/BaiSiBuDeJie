//
//  UIView+Position.m
//  Tools
//
//  Created by zhong on 16/9/12.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "UIView+Position.h"

@implementation UIView (Position)

// Getters

- (CGSize) size {
    return self.frame.size;
}

- (CGFloat) top {
    return self.frame.origin.y;
}

- (CGFloat) bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat) left {
    return self.frame.origin.x;
}

- (CGFloat) right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat) width {
    return self.frame.size.width;
}

- (CGFloat) height {
    return self.frame.size.height;
}

- (CGFloat) centerX {
    return self.center.x;
}

- (CGFloat) centerY {
    return self.center.y;
}

// Setters

- (void)setCenterX:(CGFloat) centerX {
    self.center = CGPointMake( centerX, self.center.y);
}

- (void)setCenterY:(CGFloat) centerY {
    self.center = CGPointMake(self.center.x,  centerY);
}

- (void)setSize:(CGSize) size {
    CGRect newFrame = self.frame;
    newFrame.size =  size;
    self.frame = newFrame;
}

- (void)setWidth:(CGFloat) width {
    CGRect newFrame = self.frame;
    newFrame.size.width =  width;
    self.frame = newFrame;
}

- (void)setHeight:(CGFloat) height {
    CGRect newFrame = self.frame;
    newFrame.size.height =  height;
    self.frame = newFrame;
}

- (void)setLeft:(CGFloat) left {
    CGRect newFrame = self.frame;
    newFrame.origin.x =  left;
    self.frame = newFrame;
}

- (void)setRight:(CGFloat) right {
    CGRect newFrame = self.frame;
    newFrame.origin.x =  right - newFrame.size.width;
    self.frame = newFrame;
}

- (void)setTop:(CGFloat) top {
    CGRect newFrame = self.frame;
    newFrame.origin.y =  top;
    self.frame = newFrame;
}

- (void)setBottom:(CGFloat) bottom {
    CGRect newFrame = self.frame;
    newFrame.origin.y =  bottom - self.frame.size.height;
    self.frame = newFrame;
}

@end
