//
//  MainTabBarItem.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "MainTabBarItem.h"

@implementation MainTabBarItem

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (self.currentImage) {
        CGFloat width = self.currentImage.size.width;
        CGFloat height = self.currentImage.size.height;
        CGFloat x = (contentRect.size.width - width) * 0.5;
        CGFloat y = 5.0;
        return CGRectMake(x, y, width, height);
    }
    return CGRectZero;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    if (self.currentTitle) {
        CGSize maxSize = contentRect.size;
        CGRect textRect = [self.currentTitle boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
        CGFloat width = textRect.size.width;
        CGFloat height = textRect.size.height;
        CGFloat x = (contentRect.size.width - width) * 0.5;
        CGFloat y = contentRect.size.height - height - 2;
        return CGRectMake(x, y, width, height);
    }
    return CGRectZero;
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
