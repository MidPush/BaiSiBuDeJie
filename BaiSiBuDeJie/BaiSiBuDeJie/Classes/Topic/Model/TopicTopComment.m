//
//  TopicTopComment.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicTopComment.h"

@implementation TopicTopComment
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"commentId" : @"id",
             @"user" : @"u"
             };
}
@end
