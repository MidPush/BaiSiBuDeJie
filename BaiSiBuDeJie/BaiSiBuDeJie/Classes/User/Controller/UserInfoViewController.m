//
//  UserInfoViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/23.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "UserInfoViewController.h"
#import "MJRefresh.h"
#import "User.h"
#import "ProfileInfo.h"
#import "ProfileHeaderView.h"
#import "UIImageView+WebCache.h"

@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource> {
    BOOL _isDragging;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) ProfileInfo *profileInfo;

@end

@implementation UserInfoViewController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        _tableView.mj_footer.hidden = YES;

        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavigationBar];
    [self setupTableView];
    [self.view addSubview:self.tableView];
    
    NSString *userId = self.user.userId;
    if (!userId) {
        userId = self.user.uid;
    }
    [ApiEngine getUserProfileInfo:userId result:^(BOOL success, id data) {
        if (success) {
            self.profileInfo = data;
            [self updateHeaderView];
        }else {
            
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bubble_Color_5_260x60_@1x"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}


- (void)setupTableView {
    // background_image
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -100, self.view.width, 400)];
    UIView *coverView = [[UIView alloc] initWithFrame:_backgroundImageView.bounds];
    coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [_backgroundImageView addSubview:coverView];
    [self.view addSubview:_backgroundImageView];
    
    // tableView 
    ProfileHeaderView *headerView = [ProfileHeaderView headerView];
    headerView.frame = CGRectMake(0, 0, 0, 330);
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:self.tableView];
}

- (void)updateHeaderView {
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.profileInfo.background_image] placeholderImage:[UIImage imageNamed:@""]];
    ProfileHeaderView *headerView = (ProfileHeaderView *)self.tableView.tableHeaderView;
    headerView.profileInfo = self.profileInfo;
}

- (void)loadMoreData {
    
}

- (void)setupNavigationBar {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    NSString *username = self.user.name;
    if (username.length == 0) {
        username = self.user.username;
    }
    self.navigationItem.title = username;
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"comment_nav_item_share_icon_22x3_"] highlightImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click_22x3_"] target:self action:@selector(menuItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)menuItemClick {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"帖子筛选",@"正序",@"倒序",@"举报", nil];
    [sheet showInView:self.view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_isDragging) return;
    //偏移量
    CGFloat offset = scrollView.contentOffset.y;
    if (offset <= 0) {
        _backgroundImageView.top = -100 - (offset / 5);
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    }else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bubble_Color_5_260x60_@1x"] forBarMetrics:UIBarMetricsDefault];
        
        _backgroundImageView.top = -100 - offset;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isDragging = YES;
}




@end
