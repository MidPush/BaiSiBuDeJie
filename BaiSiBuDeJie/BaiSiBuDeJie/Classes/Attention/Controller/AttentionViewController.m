//
//  AttentionViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "AttentionViewController.h"
#import "RecommandViewController.h"
#import "UIView+Xib.h"
#import "VisitorView.h"
#import "LoginRegisterViewController.h"

@interface AttentionViewController ()<VisitorViewDelegate>

@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupVisitorView];
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

- (void)setupVisitorView {
    VisitorView *visitorView = [VisitorView viewFromXib];
    visitorView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    visitorView.delegate = self;
    [self.view addSubview:visitorView];
}


- (void)leftItemClick {
    RecommandViewController *vc = [[RecommandViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)rightItemClick {
    
}

- (void)doLoginAction {
    LoginRegisterViewController *vc = [[LoginRegisterViewController alloc] initWithNibName:@"LoginRegisterViewController" bundle:nil];
    vc.showType = ShowTypeLogin;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)doRegisterAction {
    LoginRegisterViewController *vc = [[LoginRegisterViewController alloc] initWithNibName:@"LoginRegisterViewController" bundle:nil];
    vc.showType = ShowTypeRigister;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
