//
//  BSVideoBrowse.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/29.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BSVideoBrowse.h"
#import "BSVideoPlayer.h"
#import "TopicLayout.h"

@interface BSVideoBrowse ()
@property (nonatomic, strong) UIControl *backgroundView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) BSVideoPlayer *player;
@property (nonatomic, strong) UIView *fromView;
@end

@implementation BSVideoBrowse

- (instancetype)initWithTopicLayout:(TopicLayout *)layout {
    if (self = [super init]) {
        _layout = layout;
        self.frame = [UIScreen mainScreen].bounds;
        _backgroundView = [[UIControl alloc] init];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _backgroundView.frame = self.bounds;
        [_backgroundView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backgroundView];
        
        
        CGFloat fromViewWidth = layout.videoContainerFrame.size.width;
        CGFloat fromViewHeight = layout.videoContainerFrame.size.height;
        _player = [[BSVideoPlayer alloc] initWithFrame:CGRectMake(0, 20, self.width, self.width * fromViewHeight / fromViewWidth)];
        _player.backgroundColor = [UIColor blackColor];
        _player.videoURL = [NSURL URLWithString:layout.topic.video.download[0]];
        [self addSubview:_player];
        
        // 关闭按钮
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"video_play_close_16x16_"] forState:UIControlStateNormal];
        _closeButton.frame = CGRectMake(15, 30, 16, 22);
        [_closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
    }
    return self;
}

- (void)showFromView:(UIView *)fromView {
    _fromView = fromView;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    UIView *snapshotView = [fromView snapshotViewAfterScreenUpdates:NO];
    CGRect fromViewFrame = [fromView convertRect:fromView.bounds toView:[UIApplication sharedApplication].keyWindow];
    snapshotView.frame = fromViewFrame;
    
    [keyWindow addSubview:snapshotView];
    
    CGFloat fromViewWidth = _layout.videoContainerFrame.size.width;
    CGFloat fromViewHeight = _layout.videoContainerFrame.size.height;
    [UIView animateWithDuration:0.4 animations:^{
        snapshotView.frame = CGRectMake(0, 20, self.width, self.width * fromViewHeight / fromViewWidth);
    } completion:^(BOOL finished) {
        [snapshotView removeFromSuperview];
    }];
}

- (void)dismiss {
    [_player.controlView removeFromSuperview];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIView *snapshotView = [_player snapshotViewAfterScreenUpdates:YES];
        [keyWindow addSubview:snapshotView];
        CGRect imageOriginFrame = [_fromView convertRect:_fromView.bounds toView:keyWindow];
        [self removeFromSuperview];
        [UIView animateWithDuration:0.4 animations:^{
            snapshotView.frame = imageOriginFrame;
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
        }];

    });
    
}

@end
