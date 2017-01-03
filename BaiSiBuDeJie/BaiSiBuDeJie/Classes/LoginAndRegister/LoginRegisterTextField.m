//
//  LoginRegisterTextField.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/31.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "LoginRegisterTextField.h"

@implementation LoginRegisterTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.tintColor = self.textColor;
        [self setValue:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tintColor = self.textColor;
    [self setValue:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forKeyPath:@"_placeholderLabel.textColor"];
}

- (BOOL)becomeFirstResponder {
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    [self setValue:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}



@end
