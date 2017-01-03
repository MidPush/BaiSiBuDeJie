//
//  VisitorView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/31.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "VisitorView.h"

@interface VisitorView ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation VisitorView

- (void)awakeFromNib {
    [super awakeFromNib];
    _loginButton.layer.cornerRadius = 3;
    _registerButton.layer.cornerRadius = 3;
    _registerButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    _registerButton.layer.borderColor = ThemeColor.CGColor;
    
}
- (IBAction)loginButtonClick {
    if ([self.delegate respondsToSelector:@selector(doLoginAction)]) {
        [self.delegate doLoginAction];
    }
}
- (IBAction)registerButtonClick {
    if ([self.delegate respondsToSelector:@selector(doRegisterAction)]) {
        [self.delegate doRegisterAction];
    }
}

@end
