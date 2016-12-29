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
#import "BSActionSheet.h"
#import "CommentToolView.h"

@interface CommentViewController ()<TopicCellDelegate, CommentToolViewDelegate>
@property (nonatomic, strong) CommentGroup *group;
@property (nonatomic, strong) CommentToolView *toolView;
@end

static NSString *identifier = @"CommentCell";
#define kSectionHeaderHeight 30
#define kToolBarHeight 49
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
    [self setupUI];
    [self loadNewData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_toolView dismissBackgroundView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

}

- (void)setupNavigationBar {
    
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"comment_nav_item_share_icon_22x3_"] highlightImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click_22x3_"] target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)setupUI {
    
    // ToolView
    _toolView = [[CommentToolView alloc] initWithFrame:CGRectMake(0, self.view.height - kToolBarHeight - 64, self.view.width, kToolBarHeight)];
    _toolView.delegate = self;
    [self.view addSubview:_toolView];
    
    // TableView
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
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)loadNewData {
    [ApiEngine getTopicCommentList:_layout.topic.topicId result:^(BOOL success, id data) {
        if (success) {
            self.group = data;
            if (self.isNeedContentOffset) {
                self.needContentOffset = NO;
                [self.tableView setContentOffset:CGPointMake(0, self.tableView.tableHeaderView.height) animated:YES];
            }
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
    if (indexPath.section == 0) {
        Comment *comment = self.group.hot[indexPath.row];
        cell.comment = comment;
    }else if (indexPath.section == 1) {
        Comment *comment = self.group.normal[indexPath.row];
        cell.comment = comment;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ((section == 0 && self.group.hot.count == 0) || self.group.normal.count == 0) return nil;
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kSectionHeaderHeight)];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
    line.backgroundColor = kBaseViewHighlightColor;
    [sectionHeaderView addSubview:line];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, kSectionHeaderHeight-13, 100, 13)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    if (section == 0) {
        label.text = @"最热评论";
    }else {
        label.text = @"最新评论";
    }
    [sectionHeaderView addSubview:label];
    return sectionHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titles = @[@"赞",@"回复",@"举报"];
    BSActionSheet *actionSheet = [[BSActionSheet alloc] initWithTitles:titles delegate:self cancelButtonTitle:@"取消"];
    [actionSheet show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    if (self.group.normal.count == 0) return CGFLOAT_MIN;
    if (section == 0) {
        // 可能没有最热评论
        if (self.group.hot.count > 0) {
            return kSectionHeaderHeight;
        }else {
            return CGFLOAT_MIN;
        }
    }else {
        return kSectionHeaderHeight;
    }
}

- (void)share{
    [ShareView show];
}

// 点赞
- (void)onClickLikeWithCell:(TopicCell *)cell {
    if(cell.layout.topic.isLike || cell.layout.topic.isDislike) return;
    [cell setLiked:YES withAnimation:YES];
    
}

// 踩
- (void)onClickDislikeWithCell:(TopicCell *)cell {
    if(cell.layout.topic.isLike || cell.layout.topic.isDislike) return;
    [cell setDisliked:YES withAnimation:YES];
}

// 分享
- (void)onClickShareWithCell:(TopicCell *)cell {
    [ShareView show];
}

- (void)commentToolViewIsEditable:(BOOL)isEditable {
    if (isEditable) {
        self.navigationController.navigationBar.userInteractionEnabled = NO;
    }else {
        self.navigationController.navigationBar.userInteractionEnabled = YES;
    }
}

@end
