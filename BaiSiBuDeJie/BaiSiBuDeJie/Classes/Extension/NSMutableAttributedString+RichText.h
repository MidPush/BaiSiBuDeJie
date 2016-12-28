//
//  NSMutableAttributedString+RichText.h
//  Tools
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (RichText)

- (void)xz_setFont:(nullable UIFont *)font range:(NSRange)range;
- (void)xz_setColor:(nullable UIColor *)color range:(NSRange)range;

@end
