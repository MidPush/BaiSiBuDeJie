//
//  NewViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "NewViewController.h"
#import "XZPagesController.h"
#import "TopicViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
    XZPagesController *pages = [[XZPagesController alloc] init];
    pages.view.frame = self.view.bounds;
    pages.showToNavigationBar = YES;
    pages.selectedIndex = 0;
    pages.topBar.itemTitles = @[@"全部",@"视频",@"图片",@"段子",@"网红",@"美女",@"冷知识",@"游戏",@"声音"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < pages.topBar.itemTitles.count; i++) {
        TopicViewController *topicVC = [[TopicViewController alloc] init];
        topicVC.newTopicType = i;
        topicVC.viewControllerType = ViewControllerTypeNew;
        [array addObject:topicVC];
    }
    
    pages.viewControllers = array.copy;
    [self addChildViewController:pages];
    [self.view addSubview:pages.view];
}

- (void)doubleTapBarItem:(UIButton *)barItem {
    NSLog(@"%@",barItem);
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"review_post_nav_icon_20x17_"] highlightImage:[UIImage imageNamed:@"review_post_nav_icon_click_20x17_"] target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
//    
//    UIColor *color = RGB(244, 14, 68);
//    UIImage *image = [color pureColorImageWithSize:CGSizeMake(15, 44 - 2)];
//    
//    UIImageView *rightCover = [[UIImageView alloc] initWithImage:image];
//    rightCover.right = self.navigationController.navigationBar.width - self.navigationItem.rightBarButtonItem.width;
//    [self.navigationController.navigationBar addSubview:rightCover];
}

- (void)rightItemClick {
    
}

@end
