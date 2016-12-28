//
//  TopicHotCommentCell.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicCell, User;
@interface TopicHotCommentCell : UITableViewCell

- (void)updateCommentLabel:(CGRect)frame text:(NSMutableAttributedString *)text;
@property (nonatomic, weak) TopicCell *topicCell;
@property (nonatomic, strong) User *user;
@end
