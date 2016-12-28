//
//  TopicToolBar.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicLayout;
@interface TopicToolBar : UIView
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *dislikeButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) TopicLayout *layout;
- (void)setLiked:(BOOL)like withAnimation:(BOOL)animation;
- (void)setDisliked:(BOOL)dislike withAnimation:(BOOL)animation;
@end
