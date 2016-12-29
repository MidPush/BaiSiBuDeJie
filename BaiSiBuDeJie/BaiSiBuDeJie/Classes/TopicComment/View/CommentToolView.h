//
//  CommentToolView.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/29.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentToolViewDelegate <NSObject>

- (void)commentToolViewIsEditable:(BOOL)isEditable;

@end
@interface CommentToolView : UIView
- (void)dismissBackgroundView;
- (void)dismiss;
@property (nonatomic, weak) id <CommentToolViewDelegate> delegate;
@end
