//
//  MeViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_coin_icon_17x19_"] highlightImage:[UIImage imageNamed:@"nav_coin_icon_click_17x19_"] target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem1 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon_20x20_"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click_20x20_"] target:self action:@selector(rightItem1Click)];
    UIBarButtonItem *rightItem2 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon_20x20_"] highlightImage:[UIImage imageNamed:@"mine-moon-icon-click_26x26_"] target:self action:@selector(rightItem2Click)];
    self.navigationItem.rightBarButtonItems = @[rightItem1, rightItem2];
    
}


- (void)leftItemClick {
    
}

-(void)rightItem1Click {
    
}

-(void)rightItem2Click {
    
}


@end
