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
    [self welcomeStars];
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_coin_icon_17x19_"] highlightImage:[UIImage imageNamed:@"nav_coin_icon_click_17x19_"] target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem1 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon_20x20_"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click_20x20_"] target:self action:@selector(rightItem1Click)];
    UIBarButtonItem *rightItem2 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon_20x20_"] highlightImage:[UIImage imageNamed:@"mine-moon-icon-click_26x26_"] target:self action:@selector(rightItem2Click)];
    self.navigationItem.rightBarButtonItems = @[rightItem1, rightItem2];
    
}

- (void)welcomeStars {
    UILabel *welcomeLabel = [[UILabel alloc] init];
    welcomeLabel.frame = CGRectMake(10, 64, self.view.width - 10 * 2, 200);
    welcomeLabel.numberOfLines = 0;
    welcomeLabel.text = @"帮忙去github点个星星吧谢谢!\n<爱你一万年>";
    welcomeLabel.textColor = [UIColor redColor];
    welcomeLabel.font = [UIFont boldSystemFontOfSize:30];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:welcomeLabel];
}

- (void)leftItemClick {
    
}

-(void)rightItem1Click {
    
}

-(void)rightItem2Click {
    
}


@end
