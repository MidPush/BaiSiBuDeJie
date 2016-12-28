//
//  Topic.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "Topic.h"

@implementation Topic
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"topicId" : @"id",
             @"user" : @"u"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tags" : [TopicTag class],
             @"top_comments" : [TopicTopComment class]};
}

@end
