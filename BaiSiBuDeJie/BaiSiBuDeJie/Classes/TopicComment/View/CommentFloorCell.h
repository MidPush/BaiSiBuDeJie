//
//  CommentFloorCell.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;
@interface CommentFloorCell : UITableViewCell

@property (nonatomic, strong) Comment *comment;
- (void)setComment:(Comment *)comment contentLabelFrame:(CGRect)contentLabelFrame contentImageViewFrame:(CGRect)contentImageViewFrame contentViewFrame:(CGRect)contentViewFrame;
@end
