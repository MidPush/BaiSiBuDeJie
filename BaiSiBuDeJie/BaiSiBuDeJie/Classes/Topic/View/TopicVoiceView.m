//
//  TopicVoiceView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/30.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicVoiceView.h"
#import "TopicLayout.h"
#import "UIImageView+WebCache.h"
#import "TopicPhotoBrowse.h"
#import <AVFoundation/AVFoundation.h>

@interface TopicVoiceView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *placeholder;
@property (nonatomic, strong) UIButton *playVoiceButton;
@property (nonatomic, strong) UIImageView *voiceBottomCover;
@property (nonatomic, strong) UILabel *voicePlayCountLabel; // 播放次数
@property (nonatomic, strong) UILabel *voiceTimeLabel; // 声音时长
@end

@implementation TopicVoiceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _placeholder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageBackground_75x15_"]];
        
        
        _imageView = [[UIImageView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureTapped:)];
        [_imageView addGestureRecognizer:tap];
        
        _playVoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playVoiceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playVoiceButton setImage:[UIImage imageNamed:@"playButtonPlay_30x30_"] forState:UIControlStateNormal];
        [_playVoiceButton setImage:[UIImage imageNamed:@"playButtonPause_26x26_"] forState:UIControlStateSelected];
        [_playVoiceButton setBackgroundImage:[UIImage imageNamed:@"playButton_63x63_"] forState:UIControlStateNormal];
        [_playVoiceButton addTarget:self action:@selector(playVoiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _voiceBottomCover = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_time_bar_shadow_50x40_"]];
        
        _voicePlayCountLabel = [[UILabel alloc] init];
        _voicePlayCountLabel.textColor = kTopicCellVideoTextColor;
        _voicePlayCountLabel.font = [UIFont systemFontOfSize:kTopicCellVideoTextFontSize];
        
        _voiceTimeLabel = [[UILabel alloc] init];
        _voiceTimeLabel.textColor = kTopicCellVideoTextColor;
        _voiceTimeLabel.font = [UIFont systemFontOfSize:kTopicCellVideoTextFontSize];
        
        
        [self addSubview:_placeholder];
        [self addSubview:_imageView];
        [self addSubview:_playVoiceButton];
        [self addSubview:_voiceBottomCover];
        [self addSubview:_voicePlayCountLabel];
        [self addSubview:_voiceTimeLabel];
    }
    return self;
}

- (void)setLayout:(TopicLayout *)layout {
    
    _layout = layout;
    
    
    _placeholder.frame = layout.voicePlaceholderFrame;
    _imageView.frame = layout.voiceImageViewFrame;
    _playVoiceButton.frame = layout.playVoiceButtonFrame;
    _voiceBottomCover.frame = layout.voiceBottomCoverFrame;
    _voicePlayCountLabel.frame = layout.voicePlayCountLabelFrame;
    _voiceTimeLabel.frame = layout.voiceTimeLabelFrame;
    
    _voicePlayCountLabel.text = layout.voicePlayCountText;
    _voiceTimeLabel.text = layout.voiceTimeText;
    _playVoiceButton.selected = layout.isPlaying;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:layout.topic.audio.thumbnail[0]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            _imageView.userInteractionEnabled = YES;
        }
    }];
    
}

#pragma mark - 不懂音频播放，这里随便实现一下。。
- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVoiceFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)playVoiceFinished:(NSNotification *)notification {
    [_player pause];
    _player = nil;
    _layout.isPlaying = NO;
    _playVoiceButton.selected = NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

static AVPlayer *_player;
- (void)playVoiceButtonClick {
    _playVoiceButton.selected = !_playVoiceButton.selected;
    NSURL *url  = [NSURL URLWithString:_layout.topic.audio.audio[0]];
    AVPlayerItem *songItem = [[AVPlayerItem alloc] initWithURL:url];
    _player = [[AVPlayer alloc] initWithPlayerItem:songItem];
    _layout.isPlaying = _playVoiceButton.selected;
    if (_playVoiceButton.selected) {
        [_player play];
    }else {
        [_player pause];
        _player = nil;
    }
   
}

- (void)pictureTapped:(UITapGestureRecognizer *)tap {
    TopicPhotoBrowse *browse = [[TopicPhotoBrowse alloc] init];
    browse.topic = _layout.topic;
    browse.fromView = (UIImageView *)tap.view;
    
    UITabBarController *rootVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:[[UINavigationController alloc] initWithRootViewController:browse] animated:NO completion:^{
        
    }];
    
}

@end
