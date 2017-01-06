//
//  UserCell.m
//  BaiSiBuDeJie
//
//  Created by zhong on 17/1/4.
//  Copyright © 2017年 Xz Studio. All rights reserved.


#import "UserCell.h"
#import "RecommandUser.h"
#import "UIView+CornerRadius.h"
#import "UIImageView+WebCache.h"
#import "NSString+Size.h"

@interface UserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;

@end

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _avatarImageView.cornerRadius = _avatarImageView.height / 2;
}


- (void)setRecommandUser:(RecommandUser *)recommandUser {
    _recommandUser = recommandUser;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:recommandUser.header] placeholderImage:[UIImage imageNamed:@"Profile_noneAvatarBg_65x65_"]];
    _usernameLabel.text = recommandUser.screen_name;
    _attentionLabel.text = [NSString stringWithFormat:@"%ld人关注", recommandUser.fans_count];
    if (recommandUser.is_vip) {
        _vipIcon.hidden = NO;
        _usernameLabel.textColor = kTopicCellUserNameVipColor;
    }else {
        _vipIcon.hidden = YES;
        _usernameLabel.textColor = kTopicCellUserNameNormalColor;
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = kBaseViewHighlightColor;
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor whiteColor];
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(setBackgroundColor:) withObject:[UIColor whiteColor] afterDelay:0.2];
    [super touchesEnded:touches withEvent:event];
}

@end
