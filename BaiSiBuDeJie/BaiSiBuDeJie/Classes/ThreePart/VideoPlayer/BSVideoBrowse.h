//
//  BSVideoBrowse.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/29.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicLayout;
@interface BSVideoBrowse : UIView
@property (nonatomic, strong) TopicLayout *layout;
- (instancetype)initWithTopicLayout:(TopicLayout *)layout;
- (void)showFromView:(UIView *)fromView;
@end
