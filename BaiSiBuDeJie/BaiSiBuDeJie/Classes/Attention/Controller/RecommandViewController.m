//
//  RecommandViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/31.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "RecommandViewController.h"
#import "CategoryCell.h"
#import "UserCell.h"
#import "RecommandCategory.h"
#import "RecommentRefreshHeader.h"

@interface RecommandViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *categoryTableView;
@property (nonatomic, strong) UITableView *userTableView;
//
@property (nonatomic, strong) NSMutableArray *categoryDatas;
//@property (nonatomic, strong) NSArray *userDatas;
@end

static NSString *userCellId = @"userCellId";
@implementation RecommandViewController

- (NSMutableArray *)categoryDatas {
    if (!_categoryDatas) {
        _categoryDatas = [NSMutableArray array];
    }
    return _categoryDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    
    [self setupTableView];
    NSArray *names = @[@"推荐", @"好友"];
    for (NSInteger i = 0; i < 2; i++) {
        RecommandCategory *category = [[RecommandCategory alloc] init];
        category.categoryId = i;
        category.name = names[i];
        [self.categoryDatas addObject:category];
    }
    
    
    [BSProgressHUD showLoading:@"加载中..."];
    /// 左边分类数据
    [ApiEngine getRecommandCategoryWithResult:^(BOOL success, NSArray *data) {
        
        if (success) {
            [BSProgressHUD hideAllToast];
            [self.categoryDatas addObjectsFromArray:data];
            [self.categoryTableView reloadData];
            [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            [self.userTableView.mj_header beginRefreshing];
        }else {
            [BSProgressHUD showNetworkError];
        }
    }];
    
}

- (void)loadNewDatas {
    RecommandCategory *category = self.categoryDatas[self.categoryTableView.indexPathForSelectedRow.row];
    if (category.categoryId == 0) {
        // 推荐好友数据
        NSDictionary *params = @{
                                 @"a" : @"friend_recommend",
                                 @"c" : @"user",
                                 @"pre" : @50
                                 };
        [ApiEngine getRecommandUser:params result:^(BOOL success, id data) {
            if (success) {
                [category.users addObjectsFromArray:data];
                [self.userTableView reloadData];
            }else {
                [BSProgressHUD showNetworkError];
            }
            [self.userTableView.mj_header endRefreshing];
        }];
        
    }else if (category.categoryId > 1) {
        // 其他分类数据
        [ApiEngine getRecommandUserWithCategoryId:[NSString stringWithFormat:@"%ld",category.categoryId] result:^(BOOL success, id data) {
            if (success) {
                [category.users addObjectsFromArray:data];
                [self.userTableView reloadData];
            }else {
                [BSProgressHUD showNetworkError];
            }
            [self.userTableView.mj_header endRefreshing];
        }];
    }
}

- (void)loadMoreDatas {
    
}

- (void)setupTableView {
    _categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 4, self.view.height - 64) style:UITableViewStylePlain];
    _categoryTableView.backgroundColor = [UIColor clearColor];
    _categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    _categoryTableView.rowHeight = 40;
    [self.view addSubview:_categoryTableView];
    
    _userTableView = [[UITableView alloc] initWithFrame:CGRectMake(_categoryTableView.right, 0, kScreenWidth - _categoryTableView.width, self.view.height - 64) style:UITableViewStylePlain];
    _userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _userTableView.backgroundColor = [UIColor clearColor];
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    _userTableView.rowHeight = 64;
    RecommentRefreshHeader *header = [RecommentRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.textColor = TextBlueColor;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    _userTableView.mj_header = header;
    
//    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
//    _userTableView.mj_footer = footer;
    [self.view addSubview:_userTableView];
    
    [_userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserCell class]) bundle:nil] forCellReuseIdentifier:userCellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _categoryTableView) {
        return self.categoryDatas.count;
    }
    RecommandCategory *category = self.categoryDatas[self.categoryTableView.indexPathForSelectedRow.row];
    return category.users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _categoryTableView) {
        CategoryCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
        if (!categoryCell) {
            categoryCell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryCell"];
        }
        categoryCell.category = self.categoryDatas[indexPath.row];
        return categoryCell;
    }
    
    UserCell *userCell = [tableView dequeueReusableCellWithIdentifier:userCellId forIndexPath:indexPath];
    RecommandCategory *category = self.categoryDatas[self.categoryTableView.indexPathForSelectedRow.row];
    userCell.recommandUser = category.users[indexPath.row];
    return userCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _categoryTableView) {
        RecommandCategory *category = self.categoryDatas[indexPath.row];
        if (indexPath.row == 1) {
            self.userTableView.scrollEnabled = NO;
            [self.userTableView reloadData];
        }else {
            self.userTableView.scrollEnabled = YES;
            if (category.users.count > 0) {
                [self.userTableView reloadData];
            }else {
                [self.userTableView reloadData];
                [self.userTableView.mj_header beginRefreshing];
            }
        }
        
    }
}

@end
