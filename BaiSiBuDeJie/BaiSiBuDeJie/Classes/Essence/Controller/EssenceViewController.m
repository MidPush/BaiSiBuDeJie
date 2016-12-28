//
//  EssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "EssenceViewController.h"
#import "XZPagesController.h"
#import "TopicViewController.h"

@interface EssenceViewController ()

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    XZPagesController *pages = [[XZPagesController alloc] init];
    pages.view.frame = self.view.bounds;
    pages.showToNavigationBar = YES;
    pages.selectedIndex = 0;
    pages.topBar.itemTitles = @[@"推荐",@"视频",@"图片",@"段子",@"网红",@"排行",@"社会",@"美女",@"冷知识",@"游戏"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < pages.topBar.itemTitles.count; i++) {
        TopicViewController *topicVC = [[TopicViewController alloc] init];
        topicVC.essencetopicType = i;
        topicVC.viewControllerType = ViewControllerTypeEssence;
        [array addObject:topicVC];
    }
    
    pages.viewControllers = array.copy;
    [self addChildViewController:pages];
    [self.view addSubview:pages.view];
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *randomItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"RandomAcrossClick_18x14_"] highlightImage:[UIImage imageNamed:@"RandomAcrossClick_18x14_"] target:self action:@selector(random)];
    self.navigationItem.rightBarButtonItem = randomItem;

}

- (void)random {
    
}

- (void)doubleTapBarItem:(UIButton *)barItem {
    NSLog(@"%@",barItem);
}



@end
