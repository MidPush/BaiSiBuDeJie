//
//  ApiEngine.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "ApiEngine.h"
#import "ApiManager.h"
#import "NSDictionary+Property.h"
#import "YYModel.h"

#import "TopicLayout.h"
#import "Topic.h"
#import "ProfileInfo.h"
#import "CommentGroup.h"
#import "RecommandCategory.h"

@implementation ApiEngine

+ (NSMutableDictionary *)commonParams {
    long timeStamp = [[NSDate date] timeIntervalSince1970];
    NSMutableDictionary *commonParams = [NSMutableDictionary dictionary];
    commonParams[@"appname"] = @"bs0315";
    commonParams[@"asid"] = @"EE533A38-ABB9-4E7C-A5A3-44E19876BB2B";
    commonParams[@"client"] = @"iphone";
    commonParams[@"device"] = @"iphone%205S";
    commonParams[@"from"] = @"ios";
    commonParams[@"jbk"] = @"0";
    commonParams[@"market"] = @"";
    commonParams[@"openudid"] = @"29899e667f47b844b4277fb9a6243c3141b55199";
    commonParams[@"t"] = @(timeStamp);
    commonParams[@"udid"] = @"";
    commonParams[@"uid"] = @"17832304";
    commonParams[@"ver"] = @"4.5";
    return commonParams;
}

+ (NSString *)topicUrlWithEssenceTopicType:(EssenceTopicType)essenceTopicType lastTopicPassTimeStamp:(NSString *)timeStamp {
    NSString *rootUrl = @"http://s.budejie.com/topic";
    NSString *path = @"";
    NSString *last = [NSString stringWithFormat:@"bs0315-iphone-4.5/%@-20.json",timeStamp];
    switch (essenceTopicType) {
        case EssenceTopicTypeTuiJian:
            path = @"list/jingxuan/1";
            break;
        case EssenceTopicTypeShiPin:
            path = @"list/jingxuan/41";
            break;
        case EssenceTopicTypeTuPian:
            path = @"list/jingxuan/10";
            break;
        case EssenceTopicTypeDuanZi:
            path = @"tag-topic/64/hot";
            break;
        case EssenceTopicTypeWangHong:
            path = @"tag-topic/3096/hot";
            break;
        case EssenceTopicTypePaiHang:
            path = @"list/remen/1";
            break;
        case EssenceTopicTypeSheHui:
            path = @"tag-topic/473/hot";
            break;
        case EssenceTopicTypeMeiNv:
            path = @"tag-topic/117/hot";
            break;
        case EssenceTopicTypeLengZhiShi:
            path = @"tag-topic/3176/hot";
            break;
        case EssenceTopicTypeYouXi:
            path = @"tag-topic/164/hot";
            break;
        default:
            break;
    }
    
    return [[rootUrl stringByAppendingPathComponent:path] stringByAppendingPathComponent:last];
    
}

+ (NSString *)topicUrlWithNewTopicType:(NewTopicType)newTopicType lastTopicPassTimeStamp:(NSString *)timeStamp {
    NSString *rootUrl = @"http://s.budejie.com/topic";
    NSString *path = @"";
    NSString *last = [NSString stringWithFormat:@"bs0315-iphone-4.5/%@-20.json",timeStamp];
    switch (newTopicType) {
        case NewTopicTypeQuanBu:
            path = @"list/zuixin/1";
            break;
        case NewTopicTypeShiPin:
            path = @"list/zuixin/41";
            break;
        case NewTopicTypeTuPian:
            path = @"list/zuixin/10";
            break;
        case NewTopicTypeDuanZi:
            path = @"list/zuixin/29";
            break;
        case NewTopicTypeWangHong:
            path = @"tag-topic/3096/new";
            break;
        case NewTopicTypeMeiNv:
            path = @"tag-topic/117/new";
            break;
        case NewTopicTypeLengZhiShi:
            path = @"tag-topic/3176/new";
            break;
        case NewTopicTypeYouXi:
            path = @"tag-topic/164/new";
            break;
        case NewTopicShengYin:
            path = @"list/zuixin/31";
            break;
        
        default:
            break;
    }
    
    return [[rootUrl stringByAppendingPathComponent:path] stringByAppendingPathComponent:last];
}

+ (void)getEssenceTopic:(EssenceTopicType)essenceTopicType lastTopicPassTimeStamp:(NSString *)timeStamp  result:(DataActionResult)reslut {
    NSString *url = [self topicUrlWithEssenceTopicType:essenceTopicType lastTopicPassTimeStamp:timeStamp];
    [ApiManager Get:url parameters:nil success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        [dict writeToFile:@"/Users/zhong/Documents/data.plist" atomically:YES];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSArray *topics = responseObject[@"list"];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:topics.count];
            for (NSDictionary *dict in topics) {
                Topic *topic = [Topic yy_modelWithDictionary:dict];
                TopicLayout *layout = [[TopicLayout alloc] initWithTopic:topic];
                [array addObject:layout];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (reslut) {
                    reslut(YES, array);
                }
            });
        });
        
    } failure:^(NSError *error) {
        if (reslut) {
            reslut(NO, nil);
        }
    }];
}

+ (void)getNewTopic:(NewTopicType)newTopicType lastTopicPassTimeStamp:(NSString *)timeStamp result:(DataActionResult)reslut {
    
    NSString *url = [self topicUrlWithNewTopicType:newTopicType lastTopicPassTimeStamp:timeStamp];
    [ApiManager Get:url parameters:nil success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        [dict writeToFile:@"/Users/zhong/Documents/data.plist" atomically:YES];
        
        NSArray *topics = responseObject[@"list"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:topics.count];
        for (NSDictionary *dict in topics) {
            Topic *topic = [Topic yy_modelWithDictionary:dict];
            TopicLayout *layout = [[TopicLayout alloc] initWithTopic:topic];
            [array addObject:layout];
        }
        if (reslut) {
            reslut(YES, array);
        }
    } failure:^(NSError *error) {
        if (reslut) {
            reslut(NO, nil);
        }
    }];
}


+ (void)getTopicCommentList:(NSString *)topicId result:(DataActionResult)reslut {
    NSString *url = [NSString stringWithFormat:@"http://c.api.budejie.com/topic/comment_list/%@/0/bs0315-iphone-4.5/0-20.json", topicId];
    [ApiManager Get:url parameters:nil success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        [dict writeToFile:@"/Users/zhong/Documents/data.plist" atomically:YES];

        CommentGroup *commentGroup = [CommentGroup yy_modelWithDictionary:dict];
        if (reslut) {
            reslut(YES, commentGroup);
        }
    } failure:^(NSError *error) {
        if (reslut) {
            reslut(NO, nil);
        }
    }];

}

+ (void)getUserProfileInfo:(NSString *)userId result:(DataActionResult)reslut {
    NSString *url = @"http://d.api.budejie.com/user/profile";
    NSMutableDictionary *params = [self commonParams];
    params[@"sex"] = @"m";
    params[@"userid"] = userId;
    
    
//    NSDictionary *params = @{
//               @"appname":@"bs0315",
//               @"asid":@"EE533A38-ABB9-4E7C-A5A3-44E19876BB2B",
//               @"client":@"iphone",
//               @"device":@"iphone%205S",
//               @"from":@"ios",
//               @"jbk":@"0",
//               @"market":@"",
//               @"openudid":@"29899e667f47b844b4277fb9a6243c3141b55199",
//               @"sex":@"m",
//               @"t":@(timeStamp),
//               @"udid":@"",
//               @"uid":userId,
//               @"userid":userId,
//               @"ver":@"4.5"
//               };
    [ApiManager Get:url parameters:params success:^(id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        [dict writeToFile:@"/Users/zhong/Documents/profile.plist" atomically:YES];
        
        ProfileInfo *profileInfo = [ProfileInfo yy_modelWithDictionary:dict];
        if (reslut) {
            reslut(YES, profileInfo);
        }
    } failure:^(NSError *error) {
        if (reslut) {
            reslut(NO, nil);
        }
    }];
}


+ (void)getRecommandCategory:(NSString *)uid result:(DataActionResult)reslut {
    NSString *url = @"http://d.api.budejie.com/subscribe/category/bs0315-iphone-4.5/0-30.json";
//    NSMutableDictionary *params = [self commonParams];
    [ApiManager Get:url parameters:nil success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        [dict writeToFile:@"/Users/zhong/Documents/subscribe.plist" atomically:YES];
        NSArray *categorys = responseObject[@"list"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:categorys.count];
        for (NSDictionary *dict in categorys) {
            RecommandCategory *category = [RecommandCategory yy_modelWithDictionary:dict];
            [array addObject:category];
        }
        if (reslut) {
            reslut(YES, array);
        }
    } failure:^(NSError *error) {
        if (reslut) {
            reslut(NO, nil);
        }
    }];
}

@end
