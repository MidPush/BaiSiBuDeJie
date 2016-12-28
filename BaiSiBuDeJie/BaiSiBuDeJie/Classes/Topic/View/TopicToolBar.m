//
//  TopicToolBar.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicToolBar.h"
#import "TopicLayout.h"

@interface TopicToolBar ()


@end

@implementation TopicToolBar

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        _likeButton = [self buttonWithImage:@"mainCellDing_20x20_" highlightImage:@"mainCellDingClick_20x20_" title:@"顶"];
        _dislikeButton = [self buttonWithImage:@"mainCellCai_20x20_" highlightImage:@"mainCellCaiClick_20x20_" title:@"踩"];
        _shareButton = [self buttonWithImage:@"mainCellShare_20x20_" highlightImage:@"mainCellShareClick_20x20_" title:@"分享"];
        _commentButton = [self buttonWithImage:@"mainCellComment_20x20_" highlightImage:@"mainCellCommentClick_20x20_" title:@"评论"];
        
        CGFloat buttonW = kScreenWidth / 4;
        CGFloat buttonH = kTopicCellToolBarHeight;
        _likeButton.frame = CGRectMake(0, 0, buttonW, buttonH);
        _dislikeButton.frame = CGRectMake(buttonW, 0, buttonW, buttonH);
        _shareButton.frame = CGRectMake(2 * buttonW, 0, buttonW, buttonH);
        _commentButton.frame = CGRectMake(3 * buttonW, 0, buttonW, buttonH);
        
        [self addSubview:_likeButton];
        [self addSubview:_dislikeButton];
        [self addSubview:_shareButton];
        [self addSubview:_commentButton];
        
        
    }
    return self;
}

- (UIButton *)buttonWithImage:(NSString *)imageName
               highlightImage:(NSString *)highlightImageName
                        title:(NSString *)title

{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIImage *backgroundHighlighted = [UIImage imageNamed:@"toolBar_background"];
    UIFont *font = [UIFont systemFontOfSize:kTopicCellToolBarButtonFontSize];
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kTopicCellToolBarButtonNormalColor forState:UIControlStateNormal];
    [button setTitleColor:kTopicCellToolBarButtonHighlightColor forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [button setBackgroundImage:backgroundHighlighted forState:UIControlStateHighlighted];
    button.imageEdgeInsets = imageEdgeInsets;
    
    return button;
}

- (void)setLayout:(TopicLayout *)layout {
    if (_layout != layout) {
        _layout = layout;
        {
            NSString *title = [self buttonTitleWithCount:layout.topic.up defaultTitle:@"顶"];
            [_likeButton setTitle:title forState:UIControlStateNormal];
            if(layout.topic.isLike) {
                [_likeButton setTitleColor:kTopicCellToolBarButtonHighlightColor forState:UIControlStateNormal];
                [_likeButton setImage:[UIImage imageNamed:@"mainCellDingClick_20x20_"] forState:UIControlStateNormal];
            }else {
                [_likeButton setTitleColor:kTopicCellToolBarButtonNormalColor forState:UIControlStateNormal];
                [_likeButton setImage:[UIImage imageNamed:@"mainCellDing_20x20_"] forState:UIControlStateNormal];
            }
        }
        {
            NSString *title = [self buttonTitleWithCount:layout.topic.down defaultTitle:@"踩"];
            [_dislikeButton setTitle:title forState:UIControlStateNormal];
            if(layout.topic.isDislike) {
                [_dislikeButton setTitleColor:kTopicCellToolBarButtonHighlightColor forState:UIControlStateNormal];
                [_dislikeButton setImage:[UIImage imageNamed:@"mainCellCaiClick_20x20_"] forState:UIControlStateNormal];
            }else {
                [_dislikeButton setTitleColor:kTopicCellToolBarButtonNormalColor forState:UIControlStateNormal];
                [_dislikeButton setImage:[UIImage imageNamed:@"mainCellCai_20x20_"] forState:UIControlStateNormal];
            }
        }
        {
            NSString *title = [self buttonTitleWithCount:layout.topic.forward defaultTitle:@"分享"];
            [_shareButton setTitle:title forState:UIControlStateNormal];
        }
        {
            NSString *title = [self buttonTitleWithCount:layout.topic.comment defaultTitle:@"评论"];
            [_commentButton setTitle:title forState:UIControlStateNormal];
        }
        
        if (layout.topic.isLike || layout.topic.isDislike) {
            _likeButton.enabled = NO;
            _dislikeButton.enabled = NO;
        }else {
            _likeButton.enabled = YES;
            _dislikeButton.enabled = YES;
        }
        
    }
}

- (void)setLiked:(BOOL)like withAnimation:(BOOL)animation {
    if (_layout.topic.isLike == like) return;
    
    NSInteger newCount = _layout.topic.up;
    newCount = like ? newCount + 1 : newCount - 1;
    
    if (newCount == 0) {
        [_likeButton setTitleColor:kTopicCellToolBarButtonNormalColor forState:UIControlStateNormal];
        [_likeButton setTitle:@"顶" forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"mainCellDingClick_20x20_"] forState:UIControlStateNormal];
        
    }else {
        [_likeButton setTitle:[self buttonTitleWithCount:newCount defaultTitle:@"顶"] forState:UIControlStateNormal];
        if (like) {
            _likeButton.enabled = NO;
            _dislikeButton.enabled = NO;
            [_likeButton setTitleColor:kTopicCellToolBarButtonHighlightColor forState:UIControlStateNormal];
            [_likeButton setImage:[UIImage imageNamed:@"mainCellDingClick_20x20_"] forState:UIControlStateNormal];
        }
    }
    UILabel *animationLabel = [[UILabel alloc] init];
    animationLabel.text = @"+ 1";
    animationLabel.font = [UIFont systemFontOfSize:20];
    animationLabel.textColor = kTopicCellToolBarButtonHighlightColor;
    animationLabel.frame = CGRectMake(_likeButton.centerX, -5, 30, 16);
    [self addSubview:animationLabel];

    [UIView animateWithDuration:0.7 animations:^{
        animationLabel.frame = CGRectMake(_likeButton.centerX + 20, -5 - 20, 40, 20);
        animationLabel.alpha = 0;
        animationLabel.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [animationLabel removeFromSuperview];
    }];
    
    _layout.topic.isLike = like;
    _layout.topic.up = newCount;
}


- (void)setDisliked:(BOOL)dislike withAnimation:(BOOL)animation {
    if (_layout.topic.isDislike == dislike) return;
    
    NSInteger newCount = _layout.topic.down;
    newCount = dislike ? newCount + 1 : newCount - 1;
    
    if (newCount == 0) {
        [_dislikeButton setTitleColor:kTopicCellToolBarButtonNormalColor forState:UIControlStateNormal];
        [_dislikeButton setTitle:@"踩" forState:UIControlStateNormal];
        [_dislikeButton setImage:[UIImage imageNamed:@"mainCellCaiClick_20x20_"] forState:UIControlStateNormal];
        
    }else {
        [_dislikeButton setTitle:[self buttonTitleWithCount:newCount defaultTitle:@"踩"] forState:UIControlStateNormal];
        if (dislike) {
            _dislikeButton.enabled = NO;
            _likeButton.enabled = NO;
            [_dislikeButton setTitleColor:kTopicCellToolBarButtonHighlightColor forState:UIControlStateNormal];
            [_dislikeButton setImage:[UIImage imageNamed:@"mainCellCaiClick_20x20_"] forState:UIControlStateNormal];
        }
    }
    
    UILabel *animationLabel = [[UILabel alloc] init];
    animationLabel.text = @"+ 1";
    animationLabel.font = [UIFont systemFontOfSize:20];
    animationLabel.textColor = kTopicCellToolBarButtonHighlightColor;
    animationLabel.frame = CGRectMake(_dislikeButton.centerX, -5, 30, 16);
    [self addSubview:animationLabel];
    [UIView animateWithDuration:0.7 animations:^{
        animationLabel.frame = CGRectMake(_dislikeButton.centerX + 20, -5 - 20, 40, 20);
        animationLabel.alpha = 0;
        animationLabel.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [animationLabel removeFromSuperview];
    }];
    
    _layout.topic.isDislike = dislike;
    _layout.topic.down = newCount;
}

- (NSString *)buttonTitleWithCount:(NSInteger)count defaultTitle:(NSString *)title{
    if (count <= 0) {
        return title;
    }
    if (count > 9999) {
        return [NSString stringWithFormat:@"%ld万",count / 10000];
    }
    return [NSString stringWithFormat:@"%ld",count];
    
}


@end
