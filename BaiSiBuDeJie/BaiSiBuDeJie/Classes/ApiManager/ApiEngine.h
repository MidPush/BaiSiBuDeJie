//
//  ApiEngine.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EssenceTopicType) {
    EssenceTopicTypeTuiJian,
    EssenceTopicTypeShiPin,
    EssenceTopicTypeTuPian,
    EssenceTopicTypeDuanZi,
    EssenceTopicTypeWangHong,
    EssenceTopicTypePaiHang,
    EssenceTopicTypeSheHui,
    EssenceTopicTypeMeiNv,
    EssenceTopicTypeLengZhiShi,
    EssenceTopicTypeYouXi,
};

typedef NS_ENUM(NSUInteger, NewTopicType) {
    NewTopicTypeQuanBu,
    NewTopicTypeShiPin,
    NewTopicTypeTuPian,
    NewTopicTypeDuanZi,
    NewTopicTypeWangHong,
    NewTopicTypeMeiNv,
    NewTopicTypeLengZhiShi,
    NewTopicTypeYouXi,
    NewTopicTypeShengYin,
};

typedef void (^DataActionResult)(BOOL success, id data);

@interface ApiEngine : NSObject

/// 获取精华帖子数据
+ (void)getEssenceTopic:(EssenceTopicType)essenceTopicType lastTopicPassTimeStamp:(NSString *)timeStamp result:(DataActionResult)reslut;

/// 获取新帖数据
+ (void)getNewTopic:(NewTopicType)newTopic lastTopicPassTimeStamp:(NSString *)timeStamp result:(DataActionResult)reslut;

/// 获取帖子评论详情数据
+ (void)getTopicCommentList:(NSString *)topicId result:(DataActionResult)reslut;

/// 获取个人主页数据
+ (void)getUserProfileInfo:(NSString *)userId result:(DataActionResult)reslut;

/// 获取推荐关注分类数据
+ (void)getRecommandCategoryWithResult:(DataActionResult)reslut;

/// 获取推荐关注分类用户数据（网红、精品等。）
+ (void)getRecommandUserWithCategoryId:(NSString *)categoryId result:(DataActionResult)reslut;

/// 获取推荐关注用户数据(推荐)
+ (void)getRecommandUser:(NSDictionary *)params result:(DataActionResult)reslut;


@end
