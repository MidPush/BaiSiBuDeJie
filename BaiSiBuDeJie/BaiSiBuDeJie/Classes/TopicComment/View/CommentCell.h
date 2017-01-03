//
//  CommentCell.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;
@protocol CommentCellDelegate <NSObject>

- (void)onClickUserNameOrAvatar:(Comment *)comment;

@end
@interface CommentCell : UITableViewCell
@property (nonatomic, strong) Comment *comment;
@property (nonatomic, weak) id <CommentCellDelegate> delegate;
@end
