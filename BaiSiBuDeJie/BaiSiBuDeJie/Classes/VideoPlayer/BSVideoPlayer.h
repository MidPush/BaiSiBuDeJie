//
//  BSVideoPlayer.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/29.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSVideoPlayerControlView.h"

@interface BSVideoPlayer : UIView
@property (nonatomic, strong) NSURL *videoURL;
/** 控制层View */
@property (nonatomic, strong) BSVideoPlayerControlView *controlView;

- (void)play;
- (void)pause;
- (void)stop;
@end
