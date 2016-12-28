//
//  UIBarButtonItem+Item.m
//  Tools
//
//  Created by zhong on 16/9/12.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
//    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
//    [containView addSubview:btn];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}



+ (UIBarButtonItem *)itemWithTitle:(NSString *)title color:(UIColor *)color  highlightColor:(UIColor *)highlightColor target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:highlightColor forState:UIControlStateHighlighted];
    [btn sizeToFit];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
