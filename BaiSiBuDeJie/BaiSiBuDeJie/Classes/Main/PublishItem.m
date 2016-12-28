//
//  PublishItem.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/28.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "PublishItem.h"

@implementation PublishItem

- (instancetype)initWithItemIcon:(NSString *)imageName title:(NSString *)title {
    if (self = [super init]) {
        _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = kTopicCellTextColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = title;
        
        [self addSubview:_icon];
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _icon.left = (self.width - _icon.width) * 0.5;
    
    _titleLabel.left = 0;
    _titleLabel.height = 20;
    _titleLabel.bottom = self.height;
    _titleLabel.width = self.width;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.25 animations:^{
        _icon.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1f, 1.1f);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.25 animations:^{
        _icon.transform = CGAffineTransformIdentity;
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.25 animations:^{
        _icon.transform = CGAffineTransformIdentity;
    }];
    if ([self.delegate respondsToSelector:@selector(composeItemTapped:)]) {
        [self.delegate composeItemTapped:self];
    }
}



@end
