//
//  CommentViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/26.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "CommentViewController.h"
#import "ShareView.h"
#import "CommentCell.h"
#import "TopicCell.h"
#import "TopicLayout.h"
#import "CommentGroup.h"

@interface CommentViewController ()<TopicCellDelegate>
@property (nonatomic, strong) CommentGroup *group;
@end

static NSString *identifier = @"CommentCell";
@implementation CommentViewController

- (instancetype)init {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论";
    [self setupNavigationBar];
    [self setupTableHeaderView];
    [self loadNewData];
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"comment_nav_item_share_icon_22x3_"] highlightImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click_22x3_"] target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)setupTableHeaderView {
    TopicCell *headerView = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    headerView.clipsToBounds = YES;
    if (self.layout.hotCommentViewFrame.size.height > 0) {
        headerView.height = self.layout.topicCellHeight - (self.layout.hotCommentViewFrame.size.height + kTopicCellCellMargin);
    }else {
        headerView.height = self.layout.topicCellHeight;
    }
    headerView.layout = self.layout;
    headerView.delegate = self;
    self.tableView.tableHeaderView = headerView;
    
//    self.tableView.sectionHeaderHeight = 8;
//    self.tableView.sectionFooterHeight = 1.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)loadNewData {
    [ApiEngine getTopicCommentList:_layout.topic.topicId result:^(BOOL success, id data) {
        if (success) {
            self.group = data;
            [self.tableView reloadData];
            
        }else {
            
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.group.hot.count;
    }
    return self.group.normal.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSLog(@"%p",cell);
    if (indexPath.section == 0) {
        Comment *comment = self.group.hot[indexPath.row];
        cell.comment = comment;
    }else if (indexPath.section == 1) {
        Comment *comment = self.group.normal[indexPath.row];
        cell.comment = comment;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    TopicLayout *layout = self.datas[indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80;
    if (indexPath.section == 0) {
        Comment *comment = self.group.hot[indexPath.row];
        return comment.commentCellHeight;
    }else if (indexPath.section == 1) {
        Comment *comment = self.group.normal[indexPath.row];
        return comment.commentCellHeight;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (void)share{
    [ShareView show];
}

// 点赞
- (void)onClickLikeWithCell:(TopicCell *)cell {
    Topic *topic = cell.layout.topic;
    [cell setLiked:!topic.isLike withAnimation:YES];
    
}

// 踩
- (void)onClickDislikeWithCell:(TopicCell *)cell {
    Topic *topic = cell.layout.topic;
    [cell setDisliked:!topic.isDislike withAnimation:YES];
}

// 分享
- (void)onClickShareWithCell:(TopicCell *)cell {
    [ShareView show];
}




@end
