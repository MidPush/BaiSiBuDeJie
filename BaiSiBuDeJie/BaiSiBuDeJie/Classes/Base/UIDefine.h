//
//  UIDefine.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#ifndef UIDefine_h
#define UIDefine_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define RGB(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]

// TopicCell
#define kTopicCellAvatarWidth 35 // 头像宽
#define kTopicCellCellMargin 12 //帖子cell间距
#define kTopicCellToolBarHeight 40
// Fonts
#define kTopicCellNameFontSize 12 // 昵称字体大小
#define kTopicCellTimeFontSize 10 // 时间字体大小
#define kTopicCellTextFontSize 17 // 正文字体大小
#define kTopicCellVideoTextFontSize 14 // 视频帖子字体大小
#define kTopicCellToolBarButtonFontSize 14 // 工具条按钮字体大小
#define kTopicCellCommentFontSize 14 // 热门评论字体大小
// Colors
#define kTopicCellUserNameNormalColor [UIColor colorWithRGBHexString:@"333333"]// 发帖人昵称非会员字体颜色
#define kTopicCellUserNameVipColor RGB(255, 56, 16)// 发帖人昵称会员字体颜色
#define kTopicCellTimeColor [UIColor grayColor] //时间字体颜色
#define kTopicCellTextColor [UIColor colorWithRGBHexString:@"333333"] //正文字体颜色
#define kTopicCellVideoTextColor [UIColor whiteColor] //视频帖子字体颜色
#define kTopicCellToolBarButtonNormalColor [UIColor grayColor] // 工具条按钮字体颜色
#define kTopicCellToolBarButtonHighlightColor ThemeColor // 工具条按钮高亮字体颜色
#define kTopicCellCommentUserNameColor [UIColor colorWithRGBHexString:@"527ead"] // 评论用户昵称字体颜色
#define kTopicCellCommentTextColor [UIColor colorWithRGBHexString:@"5d5d5d"] // 评论字体颜色

#define ThemeColor RGB(244, 14, 68)
#define TextBlackColor [UIColor blackColor] // 黑色
#define TextGrayColor [UIColor grayColor] // 灰色
#define TextBlueColor kTopicCellCommentUserNameColor // 蓝色

#endif /* UIDefine_h */
