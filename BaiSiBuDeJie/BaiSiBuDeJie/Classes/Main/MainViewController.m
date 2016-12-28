//
//  MainViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "MainViewController.h"
#import "BSNavigationController.h"
#import "MainTabBarItem.h"
#import "PublishView.h"

#import "EssenceViewController.h"
#import "NewViewController.h"
#import "AttentionViewController.h"
#import "MeViewController.h"

@interface MainViewController ()<PublishViewDelegate>
{
    UIButton *_previosButton;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewControllers];
    [self customTabBar];
}

- (void)customTabBar {
    
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *images = @[@"tabBar_essence_icon_26x23_",
                        @"tabBar_new_icon_26x23_",
                        @"tabBar_friendTrends_icon_26x23_",
                        @"tabBar_me_icon_26x23_"
                        ];
    NSArray *selectedImages = @[@"tabBar_essence_click_icon_26x23_",
                                @"tabBar_new_click_icon_26x23_",
                                @"tabBar_friendTrends_click_icon_26x23_",
                                @"tabBar_me_click_icon_26x23_"
                                ];
    
    NSArray *tabBarItemTitles = @[@"精华",@"最新",@"关注",@"我"];
    
    CGFloat tabBarItemWidth = kScreenWidth / (images.count + 1);
    CGFloat tabBarItemHeight = self.tabBar.height;
    for (NSInteger index = 0; index < images.count; index++) {
        MainTabBarItem *tabBarItem = [[MainTabBarItem alloc] init];
        tabBarItem.tag = index;
        tabBarItem.adjustsImageWhenHighlighted = NO;
        tabBarItem.adjustsImageWhenDisabled = NO;
        tabBarItem.titleLabel.font = [UIFont systemFontOfSize:11];
        [tabBarItem setTitle:tabBarItemTitles[index] forState:UIControlStateNormal];
        [tabBarItem setImage:[UIImage imageNamed:images[index]] forState:UIControlStateNormal];
        [tabBarItem setImage:[UIImage imageNamed:selectedImages[index]] forState:UIControlStateSelected];
        [tabBarItem setTitleColor:RGB(128, 128, 128) forState:UIControlStateNormal];
        [tabBarItem setTitleColor:RGB(244, 14, 68) forState:UIControlStateSelected];
        [tabBarItem addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (index < 2) {
            tabBarItem.frame = CGRectMake(index * tabBarItemWidth, 0, tabBarItemWidth, tabBarItemHeight);
        }else {
            tabBarItem.frame = CGRectMake((index + 1) * tabBarItemWidth, 0, tabBarItemWidth, tabBarItemHeight);
        }
        
        [self.tabBar addSubview:tabBarItem];
        if (index == 0) {
            [self onButtonClick:tabBarItem];
        }
    }
    // tabBar中间的按钮
    UIButton *composeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [composeButton setImage:[UIImage imageNamed:@"tabBar_publish_icon_38x38_"] forState:UIControlStateNormal];
    [composeButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon_38x38_"] forState:UIControlStateHighlighted];
    composeButton.frame = CGRectMake(2 * tabBarItemWidth, 0, tabBarItemWidth, tabBarItemHeight);
    [composeButton addTarget:self action:@selector(onComposeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:composeButton];
}

- (void)onButtonClick:(UIButton *)button {
    if (button == _previosButton) {
        /// 重复点击 Button
        BSNavigationController *nav = self.childViewControllers[button.tag];
        UIViewController *viewController = nav.childViewControllers[0];
        if (button.tag == 0) {
            EssenceViewController *essenceVc = (EssenceViewController *)viewController;
            [essenceVc doubleTapBarItem:button];
        }else if (button.tag == 1) {
            NewViewController *newVc = (NewViewController *)viewController;
            [newVc doubleTapBarItem:button];
        }else if (button.tag == 2) {
            AttentionViewController *attentionVc = (AttentionViewController *)viewController;
            [attentionVc doubleTapBarItem:button];
        }
    }else {
        _previosButton.selected = NO;
        _previosButton = button;
        button.selected = YES;
        self.selectedIndex = button.tag;
    }
}

- (void)setupChildViewControllers {
    
    EssenceViewController *essenceVc = [[EssenceViewController alloc] init];
    essenceVc.navigationItem.title = @"精华";
    
    NewViewController *newVc = [[NewViewController alloc] init];
    newVc.navigationItem.title = @"最新";
    
    AttentionViewController *attentionVc = [[AttentionViewController alloc] init];
    attentionVc.navigationItem.title = @"关注";
    
    MeViewController *profileVc = [[MeViewController alloc] init];
    profileVc.navigationItem.title = @"我的";
    
    
    NSArray *viewControllers = @[essenceVc, newVc, attentionVc, profileVc];
    NSMutableArray *navs = [NSMutableArray arrayWithCapacity:viewControllers.count];
    for (UIViewController *childVc in viewControllers) {
        BSNavigationController *nav = [[BSNavigationController alloc] initWithRootViewController:childVc];
        [navs addObject:nav];
    }
    self.viewControllers = navs.copy;
    
}

- (void)onComposeButtonClick {
    PublishView *publishView = [[PublishView alloc] initWithFrame:self.view.bounds];
    publishView.backgroundColor = [UIColor colorWithWhite:0.98 alpha:0.99];
    publishView.delegate = self;
    [self.view addSubview:publishView];
}

- (void)onClickPublishItem:(PublishItem *)publishItem {
    BSLog(@"%@",publishItem.titleLabel.text);
}


@end
