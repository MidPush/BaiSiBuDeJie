//
//  BSNavigationController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BSNavigationController.h"

@interface BSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.titleTextAttributes = @{
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                                               NSForegroundColorAttributeName:[UIColor whiteColor]
                                              };
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bubble_Color_5_260x60_@1x"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
    // 全屏返回手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate= self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn_15x21_"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick_15x21_"] forState:UIControlStateHighlighted];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:RGB(234, 234, 234) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem = backItem;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count > 1;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
    CGPoint translationPoint = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.view];
    
    NSLog(@"touchPoint - %@",NSStringFromCGPoint(touchPoint));
    NSLog(@"translationPoint - %@",NSStringFromCGPoint(translationPoint));
    return translationPoint.x > 0 && translationPoint.y == 0;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
