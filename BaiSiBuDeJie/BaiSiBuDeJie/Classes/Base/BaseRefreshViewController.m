//
//  BaseRefreshViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BaseRefreshViewController.h"

@interface BaseRefreshViewController ()

@end



@implementation BaseRefreshViewController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [header setImages:@[[UIImage imageNamed:@"bdj_mj_refresh_2"]] forState:MJRefreshStateIdle];
        [header setImages:@[[UIImage imageNamed:@"bdj_mj_refresh_1"]] forState:MJRefreshStatePulling];
        [header setImages:@[[UIImage imageNamed:@"bdj_mj_refresh_1"],
                            [UIImage imageNamed:@"bdj_mj_refresh_2"],
                            [UIImage imageNamed:@"bdj_mj_refresh_3"],
                            [UIImage imageNamed:@"bdj_mj_refresh_4"]] forState:MJRefreshStateRefreshing];
        _tableView.mj_header = header;
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        _tableView.mj_footer.hidden = YES;
        
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)loadNewData {}
- (void)loadMoreData {}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
