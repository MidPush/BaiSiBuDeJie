//
//  TopicCell.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicLayout, TopicCell, User;
@protocol TopicCellDelegate <NSObject>

@optional
- (void)onClickLikeWithCell:(TopicCell *)cell;
- (void)onClickDislikeWithCell:(TopicCell *)cell;
- (void)onClickShareWithCell:(TopicCell *)cell;
- (void)onClickCommentWithCell:(TopicCell *)cell;
- (void)onClickUserWithCell:(TopicCell *)cell;
- (void)onClickLongTextButtonWithCell:(TopicCell *)cell;
- (void)onClickCommentViewWithCell:(TopicCell *)cell;
- (void)onClickCommentUserName:(User *)user;

@end
@interface TopicCell : UITableViewCell
@property (nonatomic, strong) TopicLayout *layout;
@property (nonatomic, weak) id <TopicCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign,getter=isShowHotCommentView) BOOL showHotCommentView;

- (void)setLiked:(BOOL)like withAnimation:(BOOL)animation;
- (void)setDisliked:(BOOL)dislike withAnimation:(BOOL)animation;
@end
