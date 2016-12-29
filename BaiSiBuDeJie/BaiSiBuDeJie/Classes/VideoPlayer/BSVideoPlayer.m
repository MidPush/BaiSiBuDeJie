//
//  BSVideoPlayer.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/29.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BSVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "BSVideoPlayerControlView.h"

@interface BSVideoPlayer ()<BSVideoPlayerControlViewDelegate>
/// 播放器
@property(nonatomic, strong)AVPlayer *player;

/// 一个视频资源
@property (nonatomic, strong) AVPlayerItem *playerItem;

/// 视频信息
@property (nonatomic, strong) AVURLAsset *urlAsset;

/// 视频某一帧图片
@property (nonatomic, strong) AVAssetImageGenerator  *imageGenerator;

/// 当前图像层
@property (nonatomic, strong) AVPlayerLayer *playerLayer;


@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation BSVideoPlayer

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setVideoURL:(NSURL *)videoURL {
    _videoURL = videoURL;
    [self setupPlayer];
}

- (void)setupPlayer {
    self.urlAsset = [AVURLAsset assetWithURL:self.videoURL];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    // 此处为默认视频填充模式
    self.playerLayer.frame = self.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer insertSublayer:self.playerLayer atIndex:0];
    
    self.controlView  = [[BSVideoPlayerControlView alloc] initWithFrame:self.bounds];
    self.controlView.delegate = self;
    [self addSubview:self.controlView];
    
    //[self timeObserver];
}

- (void)timeObserver {
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateProgress {
    
    if (self.playerItem.duration.timescale == 0) {
        return;
    }
    
    // 更新slider
    
    CGFloat currentTime = (CGFloat)CMTimeGetSeconds(self.playerItem.currentTime);
    NSInteger totalTime = self.playerItem.duration.value / self.playerItem.duration.timescale;;
//    NSLog(@"%.2f",current / total);
//    controlView.progressSlider.value = current / total;
    
    [self.controlView updateProgressWithCurrentTime:currentTime totalTime:totalTime];
}

- (void)autoPlayVideo {
    [self setupPlayer];
}

- (void)play {
    [self addDisplayLink];
    [self.player play];
}

- (void)pause {
    [self removeDisplayLink];
    [self.player pause];
}

- (void)stop {
    [self removeDisplayLink];
    [_player pause];
    [_player cancelPendingPrerolls];
    [_playerLayer removeFromSuperlayer];
    _playerLayer = nil;
    _playerItem = nil;
    _player = nil;
    _videoURL = nil;
}

- (void)addDisplayLink {
    [self displayLink];
}

- (void)removeDisplayLink {
    [_displayLink invalidate];
    _displayLink = nil;
}

#pragma mark - <BSVideoPlayerControlViewDelegate>
- (void)onClickPlayButton:(UIButton *)playButton {
    playButton.selected = !playButton.selected;
    if (playButton.selected) {
        [self play];
        [playButton setImage:[UIImage imageNamed:@"voice-play-pause_53x53_"] forState:UIControlStateNormal];
    }else {
        [self pause];;
        [playButton setImage:[UIImage imageNamed:@"voice-play-start_53x53_"] forState:UIControlStateNormal];
    }
}

- (void)sliderValueChanged {
    if (_displayLink) {
        [self removeDisplayLink];
    }
}
- (void)sliderTouchDidEnd:(CGFloat)value {
    [self addDisplayLink];
    BSLog(@"%.2f",value);
}

- (void)dealloc {
    [self stop];
}


@end
