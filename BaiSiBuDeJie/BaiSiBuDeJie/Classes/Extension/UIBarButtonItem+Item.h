//
//  UIBarButtonItem+Item.h
//  Tools
//
//  Created by zhong on 16/9/12.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
// 高亮
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title color:(UIColor *)color  highlightColor:(UIColor *)highlightColor target:(id)target action:(SEL)action;
@end
