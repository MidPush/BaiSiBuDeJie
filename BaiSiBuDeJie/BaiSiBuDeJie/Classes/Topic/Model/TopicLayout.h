//
//  TopicLayout.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"
@interface TopicLayout : NSObject
- (instancetype)initWithTopic:(Topic *)topic;
- (void)reloadLayoutForLongText;

@property (nonatomic, strong) Topic *topic;
@property (nonatomic, assign) BOOL isPicture; // 图片
@property (nonatomic, assign) BOOL isLongPicture; // 长图
@property (nonatomic, assign) BOOL isVideo; // 视频
@property (nonatomic, assign) BOOL isVoice; // 声音
@property (nonatomic, assign) BOOL isGifPicture; // Gif图片
@property (nonatomic, assign) BOOL isHtmlPicture; // Html
@property (nonatomic, assign) BOOL hasTopComment; // 热门评论
@property (nonatomic, assign) BOOL isLongText; // 长文
@property (nonatomic, assign) BOOL isShowLongText; // 是否已经显示完整文字
@property (nonatomic, assign) BOOL isPlaying; // 是否正在播放mp3

// 分隔线
@property (nonatomic, assign) CGRect separatorFrame;

// 个人资料
@property (nonatomic, assign) CGRect profileFrame;
@property (nonatomic, assign) CGRect avatarFrame;
@property (nonatomic, assign) CGRect avatarBadgeFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect vipIconFrame;
@property (nonatomic, assign) CGRect timeFrame;

// 帖子内容
@property (nonatomic, assign) CGRect textFrame; // 帖子文字Frame
@property (nonatomic, assign) CGRect longTextButtonFrame;

// 图片
@property (nonatomic, assign) CGRect pictureContainerFrame; // 图片容器Frame
@property (nonatomic, assign) CGRect imageViewFrame; // 图片Frame
@property (nonatomic, assign) CGRect placeholderFrame;
@property (nonatomic, assign) CGRect seeBigPictureBtnFrame;
// gif图片

// html图片
@property (nonatomic, assign) CGRect htmlViewFrame;
@property (nonatomic, assign) CGRect htmlImageViewFrame;
@property (nonatomic, assign) CGRect readCountLabelFrame;

// 视频
@property (nonatomic, assign) CGRect videoContainerFrame;
@property (nonatomic, assign) CGRect videoImageViewFrame; // 视频图片Frame
@property (nonatomic, assign) CGRect videoPlaceholderFrame;
@property (nonatomic, assign) CGRect playVideoButtonFrame;

@property (nonatomic, assign) CGRect videoBottomCoverFrame;
@property (nonatomic, assign) CGRect videoPlayCountLabelFrame;
@property (nonatomic, assign) CGRect videoTimeLabelFrame;
@property (nonatomic, copy) NSString *videoPlayCountText;
@property (nonatomic, copy) NSString *videoTimeText;

// 声音
@property (nonatomic, assign) CGRect voiceContainerFrame;
@property (nonatomic, assign) CGRect voiceImageViewFrame; // 声音图片Frame
@property (nonatomic, assign) CGRect voicePlaceholderFrame;
@property (nonatomic, assign) CGRect playVoiceButtonFrame;

@property (nonatomic, assign) CGRect voiceBottomCoverFrame;
@property (nonatomic, assign) CGRect voicePlayCountLabelFrame;
@property (nonatomic, assign) CGRect voiceTimeLabelFrame;
@property (nonatomic, copy) NSString *voicePlayCountText;
@property (nonatomic, copy) NSString *voiceTimeText;

// 工具栏
@property (nonatomic, assign) CGRect toolBarFrame;

// 热门评论
@property (nonatomic, assign) CGRect hotCommentViewFrame;
@property (nonatomic, assign) CGRect hotCommentTableViewFrame;
@property (nonatomic, strong) NSArray *topCommentTextFrames;
@property (nonatomic, strong) NSArray *topCommentCellHeights;
@property (nonatomic, strong) NSArray *topCommentTexts;

// 帖子cell高度
@property (nonatomic, assign) CGFloat topicCellHeight;
@property (nonatomic, assign) CGFloat topicCellLongTextHeight;
@end
