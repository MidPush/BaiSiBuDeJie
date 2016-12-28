//
//  TopicCell.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicCell.h"
#import "TopicProfileView.h"
#import "TopicPictureView.h"
#import "TopicVideoView.h"
#import "TopicToolBar.h"
#import "TopicHotCommentView.h"
#import "UIImageView+WebCache.h"

#import "TopicLayout.h"

@interface TopicCell ()

@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) TopicProfileView *profileView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *longTextButton;
@property (nonatomic, strong) TopicPictureView *pictureView;
@property (nonatomic, strong) TopicVideoView *videoView;

@property (nonatomic, strong) TopicToolBar *toolBar;
@property (nonatomic, strong) TopicHotCommentView *hotCommentView;
@end

@implementation TopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        // 分隔线
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = RGB(233, 233, 233);
        [self.contentView addSubview:_separatorView];
        
        // 个人资料
        _profileView = [[TopicProfileView alloc] init];
        [self.contentView addSubview:_profileView];
        _profileView.cell = self;
        
        // 正文文字
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:kTopicCellTextFontSize];
        _contentLabel.textColor = kTopicCellTextColor;
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:_contentLabel];
        
        // 长段子显示的按钮
        _longTextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _longTextButton.titleLabel.font = [UIFont systemFontOfSize:kTopicCellTextFontSize];
        [_longTextButton setTitleColor:kTopicCellCommentUserNameColor forState:UIControlStateNormal];
        [_longTextButton setTitle:@"全文" forState:UIControlStateNormal];
        [_longTextButton addTarget:self action:@selector(showLongText) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_longTextButton];
        
        // 图片
        _pictureView = [[TopicPictureView alloc] init];
        [self.contentView addSubview:_pictureView];
        
        // 视频
        _videoView = [[TopicVideoView alloc] init];
        [self.contentView addSubview:_videoView];
        
        // 工具栏
        _toolBar = [[TopicToolBar alloc] init];
        [self.contentView addSubview:_toolBar];
        
        // 热门评论
        _hotCommentView = [[TopicHotCommentView alloc] init];
        [self.contentView addSubview:_hotCommentView];
        _hotCommentView.cell = self;
        
        // 添加工具栏按钮点击事件
        [_toolBar.likeButton addTarget:self action:@selector(likeTopic) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar.dislikeButton addTarget:self action:@selector(dislikeTopic) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar.shareButton addTarget:self action:@selector(shareTopic) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar.commentButton addTarget:self action:@selector(commentTopic) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setLayout:(TopicLayout *)layout {
    if (_layout != layout) {
        _layout = layout;
        _separatorView.frame = layout.separatorFrame;
        _profileView.frame = layout.profileFrame;
        _contentLabel.frame = layout.textFrame;
        _pictureView.frame = layout.pictureContainerFrame;
        _videoView.frame = layout.videoContainerFrame;
        _toolBar.frame = layout.toolBarFrame;
        _hotCommentView.frame = layout.hotCommentViewFrame;
        _longTextButton.frame = layout.longTextButtonFrame;
        if (layout.isPicture || layout.isGifPicture || layout.isHtmlPicture) { // 图片
            _pictureView.hidden = NO;
            _videoView.hidden = YES;
        }else if (layout.isVideo) { // 视频
            _videoView.hidden = NO;
            _pictureView.hidden = YES;
        }
        
        
        _pictureView.layout = layout;
        _videoView.layout = layout;
        
        _profileView.layout = layout;
        _toolBar.layout = layout;
        _hotCommentView.layout = layout;
        _contentLabel.text = layout.topic.text;
        if (layout.isHtmlPicture) {
            _contentLabel.text = layout.topic.html.desc;
        }
        if (layout.isShowLongText) {
            [_longTextButton setTitle:@"收起" forState:UIControlStateNormal];
        }else {
            [_longTextButton setTitle:@"全文" forState:UIControlStateNormal];
        }
        
    }
}

- (void)setLiked:(BOOL)like withAnimation:(BOOL)animation {
    [self.toolBar setLiked:like withAnimation:animation];
}


- (void)setDisliked:(BOOL)dislike withAnimation:(BOOL)animation {
    [self.toolBar setDisliked:dislike withAnimation:animation];
}

- (void)showLongText {
    
    if ([self.delegate respondsToSelector:@selector(onClickLongTextButtonWithCell:)]) {
        [self.delegate onClickLongTextButtonWithCell:self];
    }
}

- (void)likeTopic {
    if ([self.delegate respondsToSelector:@selector(onClickLikeWithCell:)]) {
        [self.delegate onClickLikeWithCell:self];
    }
}

- (void)dislikeTopic {
    if ([self.delegate respondsToSelector:@selector(onClickDislikeWithCell:)]) {
        [self.delegate onClickDislikeWithCell:self];
    }
}

- (void)shareTopic {
    if ([self.delegate respondsToSelector:@selector(onClickShareWithCell:)]) {
        [self.delegate onClickShareWithCell:self];
    }
}

- (void)commentTopic {
    if ([self.delegate respondsToSelector:@selector(onClickCommentWithCell:)]) {
        [self.delegate onClickCommentWithCell:self];
    }
}
@end
