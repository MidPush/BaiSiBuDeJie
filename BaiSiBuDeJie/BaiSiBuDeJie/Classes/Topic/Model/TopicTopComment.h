//
//  TopicTopComment.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface TopicTopComment : NSObject

@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, copy) NSString *cmt_type;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger hate_count;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, copy) NSString *passtime;
@property (nonatomic, assign) NSInteger precid;
@property (nonatomic, assign) NSInteger preuid;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) User *user;
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, copy) NSString *voiceuri;
@end
