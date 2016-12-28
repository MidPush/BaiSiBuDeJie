//
//  TopicProfileView.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicLayout, TopicCell;
@interface TopicProfileView : UIView
@property (nonatomic, strong) TopicLayout *layout;
@property (nonatomic, weak) TopicCell *cell;
@end
