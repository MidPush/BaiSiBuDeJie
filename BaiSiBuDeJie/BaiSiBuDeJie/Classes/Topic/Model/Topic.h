//
//  Topic.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicTag.h"
#import "User.h"
#import "TopicVideo.h"
#import "TopicPicture.h"
#import "TopicGifPicture.h"
#import "TopicTopComment.h"
#import "TopicHtml.h"
#import "TopicVoice.h"

@interface Topic : NSObject
@property (nonatomic, copy) NSString *topicId;
@property (nonatomic, copy) NSString *bookmark;
@property (nonatomic, copy) NSString *passtime;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSArray <TopicTag *> *tags;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) TopicVideo *video; // 视频帖子
@property (nonatomic, strong) TopicPicture *image; // 静态图片帖子
@property (nonatomic, strong) TopicGifPicture *gif; // gif图片帖子
@property (nonatomic, strong) TopicHtml *html; // html帖子
@property (nonatomic, strong) TopicVoice *audio; // 声音帖子
@property (nonatomic, strong) NSArray <TopicTopComment *> *top_comments; // 热门评论

@property (nonatomic, assign) NSInteger up; // 顶
@property (nonatomic, assign) NSInteger down; // 踩
@property (nonatomic, assign) NSInteger forward;// 分享
@property (nonatomic, assign) NSInteger comment;// 评论

@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, assign) BOOL isDislike;

@end
