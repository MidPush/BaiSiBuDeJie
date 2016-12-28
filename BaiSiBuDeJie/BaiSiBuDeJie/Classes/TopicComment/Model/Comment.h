//
//  Comment.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentImage.h"
#import "CommentAudio.h"
#import "User.h"

@interface Comment : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *data_id;
@property (nonatomic, copy) NSString *commentId;
@property (nonatomic, assign) NSInteger floor; // 回复的楼层有此字段
@property (nonatomic, assign) NSInteger hate_count;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, strong) NSArray <Comment *> *precmts;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) CommentImage *image;
@property (nonatomic, strong) CommentAudio *audio;

// 楼中楼
@property (nonatomic, assign) CGRect relpyCommentViewFrame;
@property (nonatomic, strong) NSArray *commentFloorCellHeights;
@property (nonatomic, strong) NSArray *commentFloorImageViewFrames;
@property (nonatomic, strong) NSArray *commentFloorContentLabelFrames;
@property (nonatomic, strong) NSArray *commentFloorContentViewFrames;


//
@property (nonatomic, assign) CGRect contentLabelFrame;
@property (nonatomic, assign) CGRect contentImageViewFrame;
@property (nonatomic, assign) CGRect contentViewFrame;
@property (nonatomic, assign) CGFloat commentCellHeight;
@end
