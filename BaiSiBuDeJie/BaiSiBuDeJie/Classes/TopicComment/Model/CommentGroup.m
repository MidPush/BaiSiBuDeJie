//
//  CommentGroup.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "CommentGroup.h"

@implementation CommentGroup
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"hot" : @"hot.list",
             @"normal" : @"normal.list",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"hot" : [Comment class],
             @"normal" : [Comment class]};
}
@end
