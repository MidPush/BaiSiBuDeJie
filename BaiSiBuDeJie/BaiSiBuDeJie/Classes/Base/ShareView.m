//
//  ShareView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/26.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIButton *backgroundView;

@end
@implementation ShareView

- (void)awakeFromNib {
    [super awakeFromNib];
}


+ (void)show {
    UIView *shareView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    shareView.frame = keyWindow.frame;
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}

- (void)didMoveToWindow {
    [UIView animateWithDuration:0.25 animations:^{
        self.container.transform = CGAffineTransformMakeTranslation(0, -_container.frame.size.height);
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundView.alpha = 0;
        _container.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (IBAction)backgroundViewTapped {
    [self dismiss];
}
@end
