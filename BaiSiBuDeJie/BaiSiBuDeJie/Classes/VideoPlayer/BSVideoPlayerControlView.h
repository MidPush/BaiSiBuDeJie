//
//  BSVideoPlayerControlView.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/29.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSVideoPlayerControlViewDelegate <NSObject>

- (void)onClickPlayButton:(UIButton *)playButton;
- (void)sliderValueChanged;
- (void)sliderTouchDidEnd:(CGFloat)value;

@end
@interface BSVideoPlayerControlView : UIView

- (void)updateProgressWithCurrentTime:(CGFloat)currentTime totalTime:(NSInteger)totalTime;
@property (nonatomic, weak) id <BSVideoPlayerControlViewDelegate> delegate;
@end
