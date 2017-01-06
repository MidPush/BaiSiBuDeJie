//
//  RecommandUser.m
//  BaiSiBuDeJie
//
//  Created by zhong on 17/1/4.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import "RecommandUser.h"

@implementation RecommandUser
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"userId" : @"id",
             };
}
@end
