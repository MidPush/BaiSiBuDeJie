//
//  CommentFloorCellContentView.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;
@interface CommentFloorCellContentView : UIView
- (void)setComment:(Comment *)comment contentLabelFrame:(CGRect)contentLabelFrame contentImageViewFrame:(CGRect)contentImageViewFrame;
@end
