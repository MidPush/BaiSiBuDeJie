//
//  UIColor+Ex.h
//  FDD
//
//  Created by zhong on 16/8/11.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Ex)

- (BOOL)isRGBAWhiteColor;

+ (UIColor *)colorWithRGBHexString:(NSString *)rgbString;

+ (UIColor *)colorWithRGBHex: (unsigned int)hex;

+ (UIColor *)colorWithARGBHexString:(NSString *)argbString;

+ (UIColor *)colorWithARGBHex: (unsigned int)hex;

+ (UIColor *)colorWithHexString2: (NSString *)hexString;

- (UIImage *)pureColorImage;

- (UIImage *)pureColorImageWithSize:(CGSize)imageSize;

- (BOOL)isEqualToColor:(UIColor*)color;

@end
