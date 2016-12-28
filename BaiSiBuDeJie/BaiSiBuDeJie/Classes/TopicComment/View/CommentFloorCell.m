//
//  CommentFloorCell.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "CommentFloorCell.h"
#import "CommentFloorCellContentView.h"
#import "Comment.h"

@interface CommentFloorCell ()
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet CommentFloorCellContentView *floorContentView;

@end

@implementation CommentFloorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment_floor_cell_line_1x1_"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setComment:(Comment *)comment contentLabelFrame:(CGRect)contentLabelFrame contentImageViewFrame:(CGRect)contentImageViewFrame contentViewFrame:(CGRect)contentViewFrame {
        
        // 楼层
        _floorLabel.text = [NSString stringWithFormat:@"%ld",comment.floor];
        
        // 昵称
        NSString *username = comment.user.username;
        if (!username) {
            username = comment.user.name;
        }
        _usernameLabel.text = username;
        if (comment.user.is_vip) {
            _usernameLabel.textColor = kTopicCellUserNameVipColor;
        }else {
            _usernameLabel.textColor = TextBlueColor;
        }
    
        // 点赞数
        _likeCountLabel.text = [NSString stringWithFormat:@"%ld",comment.like_count];
        if (comment.like_count == 0) {
            _likeCountLabel.text = @"+1";
        }
        
        // 评论
        self.floorContentView.frame = contentViewFrame;
        [self.floorContentView setComment:comment contentLabelFrame:contentLabelFrame contentImageViewFrame:contentImageViewFrame];

    
}


@end
