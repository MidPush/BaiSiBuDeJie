//
//  LoginRegisterViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/31.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "LoginRegisterViewController.h"

@interface LoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftConstraint;

@end

@implementation LoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.showType == ShowTypeRigister) {
        [self showLoginOrReister:self.changeButton];
    }
    
}
- (IBAction)showLoginOrReister:(UIButton *)sender {
    
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:0.25 animations:^{
            self.loginViewLeftConstraint.constant = - kScreenWidth;
        }];
        
    }else {
        self.loginViewLeftConstraint.constant = 0;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (IBAction)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
