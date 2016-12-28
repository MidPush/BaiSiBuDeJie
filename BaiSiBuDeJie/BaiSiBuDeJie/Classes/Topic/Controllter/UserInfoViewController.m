//
//  UserInfoViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/23.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "UserInfoViewController.h"
#import "User.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.user.name;
}

@end
