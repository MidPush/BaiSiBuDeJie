//
//  BSVideoPlayerControlView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/29.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BSVideoPlayerControlView.h"

@interface BSVideoPlayerControlView ()
@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, strong) UISlider *progressSlider;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIButton *danmuButton;
@property (nonatomic, strong) UIButton *fullScreenButton;


@end

@implementation BSVideoPlayerControlView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {

    CGFloat progressSliderHeight = 31;
    CGFloat backViewHeight = 30;
    CGFloat toolViewHeight = progressSliderHeight + backViewHeight;
    // 2,工具栏
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - toolViewHeight, self.width, toolViewHeight)];
    
    // 进度条
    _progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, _toolView.width, progressSliderHeight)];
    [_progressSlider setThumbImage:[UIImage imageNamed:@"capture_pre_thumbImage_normal_14x14_"] forState:UIControlStateNormal];
    _progressSlider.minimumValue = 0.0;
    _progressSlider.maximumValue = 1.0;
    _progressSlider.minimumTrackTintColor = RGB(244, 14, 68);
    [_progressSlider addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.progressSlider addTarget:self action:@selector(sliderTouchDidEnd) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, _progressSlider.height / 2, _toolView.width, backViewHeight + _progressSlider.height / 2)];
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    // 播放按钮
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setImage:[UIImage imageNamed:@"voice-play-start_53x53_"] forState:UIControlStateNormal];
    _playButton.frame = CGRectMake(10, (backView.height - 26) / 2, 26, 26);
    [_playButton addTarget:self action:@selector(playVideoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    // 播放时间
    _currentTimeLabel = [[UILabel alloc] init];
    _currentTimeLabel.text = @"00:00";
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.font = [UIFont systemFontOfSize:14];
    [_currentTimeLabel sizeToFit];
    _currentTimeLabel.left = _playButton.right + 20;
    _currentTimeLabel.top = (backView.height - _currentTimeLabel.height) / 2;
    
    // 总时间
    _totalTimeLabel = [[UILabel alloc] init];
    _totalTimeLabel.text = @"00:00";
    _totalTimeLabel.textColor = [UIColor whiteColor];
    _totalTimeLabel.font = [UIFont systemFontOfSize:14];
    [_totalTimeLabel sizeToFit];
    _totalTimeLabel.left = _currentTimeLabel.right + 20;
    _totalTimeLabel.top = (backView.height - _totalTimeLabel.height) / 2;

    // 全屏播放按钮
    _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fullScreenButton setImage:[UIImage imageNamed:@"video_fullscreen_20x20_"] forState:UIControlStateNormal];
    _fullScreenButton.frame = CGRectMake(backView.width - 20 - 10, (backView.height - 20) / 2, 20, 20);
    // 弹幕
    _danmuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_danmuButton setImage:[UIImage imageNamed:@"video_barrage_open_29x17_"] forState:UIControlStateNormal];
    _danmuButton.frame = CGRectMake(_fullScreenButton.left - 29 - 20, (backView.height - 17) / 2, 29, 17);
    // 下载
    _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downloadButton setImage:[UIImage imageNamed:@"videoDownLoad_17x17_"] forState:UIControlStateNormal];
    _downloadButton.frame = CGRectMake(_danmuButton.left - 17 - 20, (backView.height - 17) / 2, 17, 17);
    
    [_toolView addSubview:backView];
    [_toolView addSubview:_progressSlider];
    [backView addSubview:_playButton];
    [backView addSubview:_currentTimeLabel];
    [backView addSubview:_totalTimeLabel];
    [backView addSubview:_fullScreenButton];
    [backView addSubview:_danmuButton];
    [backView addSubview:_downloadButton];
    [self addSubview:_toolView];

}

- (void)updateProgressWithCurrentTime:(CGFloat)currentTime totalTime:(NSInteger)totalTime {
    
    NSInteger proMin = (NSInteger)currentTime / 60;
    NSInteger proSec =(NSInteger)currentTime % 60;
    
    NSInteger durMin = totalTime / 60;
    NSInteger durSec = totalTime % 60;
    
    self.progressSlider.value = currentTime / totalTime;
    
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
    
    self.totalTimeLabel.text   = [NSString stringWithFormat:@"%02zd:%02zd", durMin, durSec];

}

// Slider
- (void)sliderValueChanged {
    if ([self.delegate respondsToSelector:@selector(sliderValueChanged)]) {
        [self.delegate sliderValueChanged];
    }
}

- (void)sliderTouchDidEnd {
    if ([self.delegate respondsToSelector:@selector(sliderTouchDidEnd:)]) {
        [self.delegate sliderTouchDidEnd:self.progressSlider.value];
    }
}

// 播放
- (void)playVideoButtonClick {
    if ([self.delegate respondsToSelector:@selector(onClickPlayButton:)]) {
        [self.delegate onClickPlayButton:_playButton];
    }
}

@end
