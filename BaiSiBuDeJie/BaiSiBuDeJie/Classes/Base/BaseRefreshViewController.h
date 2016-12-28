//
//  BaseRefreshViewController.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface BaseRefreshViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, strong) id data;
- (void)loadNewData;
- (void)loadMoreData;
@end
