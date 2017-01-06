//
//  RecommandCategory.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/31.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "RecommandCategory.h"

@implementation RecommandCategory
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"categoryId" : @"id",
             };
}

-(NSMutableArray *)users{
    if (_users == nil) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}
@end
