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

@interface RecommandViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *categoryTableView;
@property (nonatomic, strong) UITableView *userTableView;

@property (nonatomic, strong) NSMutableArray *categoryDatas;
@property (nonatomic, strong) NSArray *userDatas;
@end

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
        category.name = names[i];
        [self.categoryDatas addObject:category];
    }
    
    
    
    [ApiEngine getRecommandCategory:nil result:^(BOOL success, NSArray *data) {
        if (success) {
            [self.categoryDatas addObjectsFromArray:data];
            [self.categoryTableView reloadData];
            [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        }else {
            
        }
    }];
}

- (void)setupTableView {
    _categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 4, self.view.height - 49) style:UITableViewStylePlain];
    _categoryTableView.backgroundColor = [UIColor clearColor];
    _categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    _categoryTableView.rowHeight = 40;
    [self.view addSubview:_categoryTableView];
    
    _userTableView = [[UITableView alloc] initWithFrame:CGRectMake(_categoryTableView.right, 0, kScreenWidth - _categoryTableView.width, self.view.height - 49) style:UITableViewStylePlain];
    _userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _userTableView.backgroundColor = [UIColor clearColor];
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    _userTableView.rowHeight = 50;
    [self.view addSubview:_userTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _categoryTableView) {
        return self.categoryDatas.count;
    }
    return self.userDatas.count;
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
    
    UserCell *userCell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    if (!userCell) {
        userCell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserCell"];
    }
    return userCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _categoryTableView) {
        
    }
}

@end
