//
//  XZPagesController.m
//  XZPagesController
//
//  Created by zhong on 16/12/20.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "XZPagesController.h"

@interface XZPagesController ()<UIScrollViewDelegate, XZPagesControllerTopBarDelegate>
@property (nonatomic, strong) UIScrollView *pageScrollView;
@end

@implementation XZPagesController

- (XZPagesControllerTopBar *)topBar {
    if (!_topBar) {
        _topBar = [[XZPagesControllerTopBar alloc] init];
        _topBar.delegate = self;
    }
    return _topBar;
}

- (UIScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] init];
        _pageScrollView.delegate = self;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.scrollsToTop = NO;
        _pageScrollView.showsVerticalScrollIndicator = NO;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _pageScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pageScrollView]; 
}

- (CGFloat)pageScrollViewWidth {
    return CGRectGetWidth(self.view.frame);
}

- (CGFloat)pageScrollViewHeight {
    return CGRectGetHeight(self.view.frame);
}

- (void)setViewControllers:(NSArray *)viewControllers {
    if (_viewControllers != viewControllers) {
        _viewControllers = viewControllers;
        
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    self.topBar.selectedIndex = selectedIndex;
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat topBarHeight = self.topBarHeight > 0 ? self.topBarHeight : 44;
    if (self.showToNavigationBar) {
        if (self.parentViewController.navigationController) {
            self.topBar.frame = CGRectMake(0, 0, 300, topBarHeight);
            self.parentViewController.navigationItem.titleView = self.topBar;
            
        }
    }else {
        self.topBar.frame = CGRectMake(0, 0, self.view.frame.size.width,topBarHeight);
        [self.view addSubview:self.topBar];
    }
    
    self.pageScrollView.frame = CGRectMake(0, 0, self.pageScrollViewWidth, self.pageScrollViewHeight);
    self.pageScrollView.contentSize = CGSizeMake(self.viewControllers.count * CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.pageScrollView setContentOffset:CGPointMake(self.selectedIndex * self.pageScrollViewWidth, 0) animated:NO];
    
    [self scrollViewDidEndDecelerating:self.pageScrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.pageScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}


#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _selectedIndex = scrollView.contentOffset.x / self.pageScrollViewWidth;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.viewControllers.count == 0) return;
    self.selectedIndex = scrollView.contentOffset.x / self.pageScrollViewWidth;
    UIViewController *viewController = self.viewControllers[_selectedIndex];
    if ([viewController isViewLoaded]) return;
    viewController.view.frame = CGRectMake(_selectedIndex * self.pageScrollViewWidth, 0, self.pageScrollViewWidth, self.pageScrollViewHeight);
    [self addChildViewController:viewController];
    [self.pageScrollView addSubview:viewController.view];
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - <XZPagesControllerTopBarDelegate>
- (void)itemAtIndex:(NSUInteger)index didSelectInPagesContainerTopBar:(XZPagesControllerTopBar *)bar {
    if (index == self.selectedIndex) return;
    [self.pageScrollView setContentOffset:CGPointMake(index * self.pageScrollViewWidth, 0) animated:YES];
}


@end
