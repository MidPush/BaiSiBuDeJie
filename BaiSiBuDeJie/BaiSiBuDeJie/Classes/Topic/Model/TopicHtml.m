//
//  TopicHtml.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicHtml.h"

@implementation TopicHtml
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"playcount" : @"view.playcount",
             @"playfcount" : @"view.playfcount",
             };
}
@end
