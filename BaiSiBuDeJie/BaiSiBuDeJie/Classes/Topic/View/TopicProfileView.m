//
//  TopicProfileView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicProfileView.h"
#import "UIView+CornerRadius.h"
#import "TopicLayout.h"
#import "UIImageView+WebCache.h"
#import "TopicCell.h"

@interface TopicProfileView () {
    BOOL _targetTouch;
}
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *avatarBadgeView;
@property (nonatomic, strong) UIImageView *vipIcon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation TopicProfileView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // _avatarView
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(kTopicCellCellMargin, kTopicCellCellMargin, kTopicCellAvatarWidth, kTopicCellAvatarWidth)];
        _avatarView.cornerRadius = kTopicCellAvatarWidth * 0.5;
        CALayer *avatarLayer = [CALayer layer];
        avatarLayer.frame = _avatarView.bounds;
        avatarLayer.borderWidth = 1 / [UIScreen mainScreen].scale;
        avatarLayer.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
        avatarLayer.cornerRadius = _avatarView.height / 2;
        [_avatarView.layer addSublayer:avatarLayer];
        
        // _avatarBadgeView
        _avatarBadgeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tag_user_vip_icon_14x14_"]];
        _avatarBadgeView.hidden = YES;
        
        // _nickNameLabel
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:kTopicCellNameFontSize];
        _nameLabel.textColor = kTopicCellUserNameNormalColor;
        
        // vipIcon
        _vipIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_title_vip_icon_16x12_"]];
        _vipIcon.hidden = YES;

        
        // _timeLabel
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:kTopicCellTimeFontSize];
        _timeLabel.textColor = kTopicCellTimeColor;
        
        
        
        [self addSubview:_avatarView];
        [self addSubview:_avatarBadgeView];
        [self addSubview:_nameLabel];
        [self addSubview:_vipIcon];
        [self addSubview:_timeLabel];
        
    }
    return self;
}

- (void)setLayout:(TopicLayout *)layout {
    if (_layout != layout) {
        _layout = layout;
        
        _avatarView.frame = layout.avatarFrame;
        _avatarBadgeView.frame = layout.avatarBadgeFrame;
        _nameLabel.frame = layout.nameFrame;
        _vipIcon.frame = layout.vipIconFrame;
        _timeLabel.frame = layout.timeFrame;
        
        
        _nameLabel.text = layout.topic.user.name;
        if (layout.topic.user.is_v) {
            _avatarBadgeView.hidden = NO;
            
        }else {
            _avatarBadgeView.hidden = YES;
        }
        
        if (layout.topic.user.is_vip) {
            _vipIcon.hidden = NO;
            _nameLabel.textColor = kTopicCellUserNameVipColor;
        }else {
            _vipIcon.hidden = YES;
            _nameLabel.textColor = kTopicCellUserNameNormalColor;
        }
        
        [_avatarView sd_setImageWithURL:[NSURL URLWithString:layout.topic.user.header[0]] placeholderImage:[UIImage imageNamed:@"Profile_noneAvatarBg_65x65_"]];
        
        _timeLabel.text = layout.topic.passtime;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _targetTouch = NO;
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:_avatarView];
    if (CGRectContainsPoint(_avatarView.bounds, touchPoint)) {
        _targetTouch = YES;
    }
    touchPoint = [touch locationInView:_nameLabel];
    if (CGRectContainsPoint(_nameLabel.bounds, touchPoint)) {
        _targetTouch = YES;
    }
    if (!_targetTouch) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_targetTouch) {
        [super touchesCancelled:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_targetTouch) {
        [super touchesEnded:touches withEvent:event];
    }else {
        if ([_cell.delegate respondsToSelector:@selector(onClickUserWithCell:)]) {
            [_cell.delegate onClickUserWithCell:_cell];
        }
    }
}



@end
