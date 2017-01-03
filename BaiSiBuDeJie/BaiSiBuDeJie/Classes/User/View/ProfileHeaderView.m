//
//  ProfileHeaderView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/30.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "ProfileHeaderView.h"
#import "ProfileInfo.h"
#import "UIImageView+WebCache.h"
#import "UIView+CornerRadius.h"
#import "NSString+Size.h"

@interface ProfileHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *fansButton;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UIButton *levelButton;
@property (weak, nonatomic) IBOutlet UIButton *follwUserButton;

@end

@implementation ProfileHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _likeButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    _likeButton.layer.cornerRadius = _likeButton.height / 2;
    _likeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _likeButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    
    _avatarImageView.cornerRadius = _avatarImageView.height / 2;
    
    _follwUserButton.layer.cornerRadius = 5;
    _follwUserButton.layer.borderColor = kThemeColor.CGColor;
    _follwUserButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    
    
}

+ (instancetype)headerView {
    ProfileHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    return headerView;
}

- (IBAction)likeButtonClick:(UIButton *)sender {
}

- (void)setProfileInfo:(ProfileInfo *)profileInfo {
    _profileInfo = profileInfo;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:profileInfo.profile_image] placeholderImage:[UIImage imageNamed:@"Profile_noneAvatarBg_65x65_"]];
    [_likeButton setTitle:profileInfo.total_cmt_like_count forState:UIControlStateNormal];
//     CGSize size = [_likeButton.titleLabel.text textSizeWithFont:_likeButton.titleLabel.font maxSize:CGSizeMake(200, _likeButton.height)];
//    _likeButton.width = size.width + _likeButton.imageView.image.size.width + 30;
    
    NSInteger fansCount = profileInfo.fans_count;
    NSString *title = [NSString stringWithFormat:@"%ld粉丝",profileInfo.fans_count];
    if (fansCount > 999) {
        title = [NSString stringWithFormat:@"%.1fk粉丝",profileInfo.fans_count / 1000.0];
    }
    [_fansButton setTitle:title forState:UIControlStateNormal];
    [_followButton setTitle:[NSString stringWithFormat:@"%ld关注",profileInfo.follow_count] forState:UIControlStateNormal];
    [_levelButton setTitle:[NSString stringWithFormat:@"等级：LV%ld",profileInfo.level] forState:UIControlStateNormal];
}


@end
