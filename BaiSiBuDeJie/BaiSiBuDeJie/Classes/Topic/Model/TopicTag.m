//
//  TopicTag.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicTag.h"

@implementation TopicTag
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"tagId" : @"id"
             };
}
@end
