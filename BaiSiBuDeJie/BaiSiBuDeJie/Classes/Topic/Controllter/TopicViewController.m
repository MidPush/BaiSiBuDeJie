//
//  TopicViewController.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicCell.h"
#import "TopicLayout.h"
#import "UserInfoViewController.h"
#import "CommentViewController.h"
#import "ShareView.h"

@interface TopicViewController ()<TopicCellDelegate>
{
    TopicCell *_tappedTopicell;
}
@end

@implementation TopicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    TopicLayout *firstLayout = self.datas.firstObject;
    NSString *topicTime = firstLayout.topic.passtime;
    long timeStamp = 0;
    if (topicTime) {
        static NSDateFormatter *formatter = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        });
        
        NSDate *date = [formatter dateFromString:topicTime];
        timeStamp = [date timeIntervalSince1970];
    }
    
    if (self.viewControllerType == ViewControllerTypeEssence) {
        [ApiEngine getEssenceTopic:self.essencetopicType lastTopicPassTimeStamp:[NSString stringWithFormat:@"%ld",timeStamp] result:^(BOOL success, NSArray *data) {
            if (success) {
                NSMutableArray *array = [NSMutableArray array];
                if (self.datas.count == 0) {
                    array = [data mutableCopy];
                }else {
                    // 找出相同帖子
                    for (TopicLayout *newLayout in data) {
                        BOOL isHas = NO;
                        for (TopicLayout *oldLayout in self.datas) {
                            if (oldLayout.topic.topicId != newLayout.topic.topicId) {
                                isHas = NO;
                                
                            }else {
                                isHas = YES;
                                break;
                            }
                        }
                        if (!isHas) {
                            [array addObject:newLayout];
                        }
                    }
                }
                
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)];
                [self.datas insertObjects:array atIndexes:indexSet];
                [self.tableView reloadData];
                self.tableView.mj_footer.hidden = (array.count < 20);
            }else {
                
            }
            [self.tableView.mj_header endRefreshing];
        }];
    }else if (self.viewControllerType == ViewControllerTypeNew) {
        [ApiEngine getNewTopic:self.newTopicType lastTopicPassTimeStamp:[NSString stringWithFormat:@"%ld",timeStamp] result:^(BOOL success, NSArray *data) {
            if (success) {
                NSMutableArray *array = [NSMutableArray array];
                if (self.datas.count == 0) {
                    array = [data mutableCopy];
                }else {
                    // 找出相同帖子
                    for (TopicLayout *newLayout in data) {
                        BOOL isHas = NO;
                        for (TopicLayout *oldLayout in self.datas) {
                            if (oldLayout.topic.topicId != newLayout.topic.topicId) {
                                isHas = NO;
                                
                            }else {
                                isHas = YES;
                                break;
                            }
                        }
                        if (!isHas) {
                            [array addObject:newLayout];
                        }
                    }
                }
                
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)];
                [self.datas insertObjects:array atIndexes:indexSet];
                [self.tableView reloadData];
                self.tableView.mj_footer.hidden = (array.count < 20);
            }else {
                
            }
            [self.tableView.mj_header endRefreshing];
        }];
    }
    
}

- (void)loadMoreData {
    TopicLayout *lastLayout = self.datas.lastObject;
    NSString *topicTime = lastLayout.topic.passtime;
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    });
    
    NSDate *date = [formatter dateFromString:topicTime];
    long timeStamp = [date timeIntervalSince1970];
    if (self.viewControllerType == ViewControllerTypeEssence) {
        [ApiEngine getEssenceTopic:self.essencetopicType lastTopicPassTimeStamp:[NSString stringWithFormat:@"%ld",timeStamp] result:^(BOOL success, NSArray *data) {
            if (success) {
                
                [self.datas addObjectsFromArray:data];
                [self.tableView reloadData];
                self.tableView.mj_footer.hidden = (data.count < 20);
            }else {
                
            }
            [self.tableView.mj_footer endRefreshing];
        }];
    }else if (self.viewControllerType == ViewControllerTypeNew) {
        [ApiEngine getNewTopic:self.newTopicType lastTopicPassTimeStamp:[NSString stringWithFormat:@"%ld",timeStamp] result:^(BOOL success, id data) {
            
        }];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell"];
    if (!cell) {
        cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TopicCell"];
        cell.delegate = self;
    }
    TopicLayout *layout = self.datas[indexPath.row];
    cell.layout = layout;
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicLayout *layout = self.datas[indexPath.row];
    CommentViewController *vc = [[CommentViewController alloc] init];
    vc.layout = layout;
    vc.needContentOffset = NO;
    TopicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _tappedTopicell = cell;
    [self.parentViewController.parentViewController.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicLayout *layout = self.datas[indexPath.row];
    return layout.topicCellHeight;
}


// 点击用户头像或昵称
- (void)onClickUserWithCell:(TopicCell *)cell {
    UserInfoViewController *vc = [[UserInfoViewController alloc] init];
    vc.user = cell.layout.topic.user;
    [self.parentViewController.parentViewController.navigationController pushViewController:vc animated:YES];
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

// 评论
- (void)onClickCommentWithCell:(TopicCell *)cell {
    CommentViewController *vc = [[CommentViewController alloc] init];
    vc.layout = cell.layout;
    vc.needContentOffset = YES;
    _tappedTopicell = cell;
    [self.parentViewController.parentViewController.navigationController pushViewController:vc animated:YES];
}

// 点击评论View
- (void)onClickCommentViewWithCell:(TopicCell *)cell {
    CommentViewController *vc = [[CommentViewController alloc] init];
    vc.layout = cell.layout;
    vc.needContentOffset = YES;
    _tappedTopicell = cell;
    [self.parentViewController.parentViewController.navigationController pushViewController:vc animated:YES];
}

// 点击评论View的用户名
- (void)onClickCommentUserName:(User *)user {
    NSLog(@"%@",user.name);
    UserInfoViewController *vc = [[UserInfoViewController alloc] init];
    vc.user = user;
    [self.parentViewController.parentViewController.navigationController pushViewController:vc animated:YES];
}

//点击段子全文按钮
- (void)onClickLongTextButtonWithCell:(TopicCell *)cell {
    [cell.layout reloadLayoutForLongText];
    [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_tappedTopicell) {
        [self.tableView reloadRowsAtIndexPaths:@[_tappedTopicell.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}


@end
