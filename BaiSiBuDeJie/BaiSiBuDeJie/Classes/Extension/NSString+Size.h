//
//  NSString+Size.h
//  OCWeiBo
//
//  Created by zhong on 16/11/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
