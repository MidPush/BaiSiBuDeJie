//
//  NSString+Size.m
//  OCWeiBo
//
//  Created by zhong on 16/11/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:NULL].size;
}

@end
