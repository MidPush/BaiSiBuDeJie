//
//  NSMutableAttributedString+RichText.m
//  Tools
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "NSMutableAttributedString+RichText.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (RichText)

- (void)xz_setFont:(nullable UIFont *)font range:(NSRange)range {
    [self xz_setAttribute:NSFontAttributeName value:font range:range];
}
- (void)xz_setColor:(UIColor *)color range:(NSRange)range {
    [self xz_setAttribute:(id)kCTForegroundColorAttributeName value:(id)color.CGColor range:range];
    [self xz_setAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)xz_setAttribute:(NSString *)name value:(id)value range:(NSRange)range {
    if (!name || [NSNull isEqual:name]) return;
    if (value && ![NSNull isEqual:value]) [self addAttribute:name value:value range:range];
    else [self removeAttribute:name range:range];
}




@end
