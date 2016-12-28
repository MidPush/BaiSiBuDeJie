//
//  AttentionViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "AttentionViewController.h"

@interface AttentionViewController ()

@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
}

- (void)doubleTapBarItem:(UIButton *)barItem {
    NSLog(@"%@",barItem);
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon_19x17_"] highlightImage:[UIImage imageNamed:@"friendsRecommentIcon-click_19x17_"] target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_search_icon_20x20_"] highlightImage:[UIImage imageNamed:@"nav_search_icon_click_20x20_"] target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


- (void)leftItemClick {
    
}

-(void)rightItemClick {
    
}

@end
