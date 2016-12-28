//
//  TopicHotCommentView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicHotCommentView.h"
#import "TopicLayout.h"
#import "TopicHotCommentCell.h"
#import "TopicCell.h"

@interface TopicHotCommentView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation TopicHotCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(233, 233, 233);
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return self;
}

- (void)setLayout:(TopicLayout *)layout {
    if (_layout != layout) {
        _layout = layout;
        _tableView.frame = layout.hotCommentTableViewFrame;
        [_tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _layout.topic.top_comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicHotCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicHotCommentCell"];
    if (!cell) {
        cell = [[TopicHotCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TopicHotCommentCell"];
    }
    NSMutableAttributedString *text = _layout.topCommentTexts[indexPath.row];
    CGRect textFrame = [_layout.topCommentTextFrames[indexPath.row] CGRectValue];
    cell.topicCell = self.cell;
    cell.user = _layout.topic.top_comments[indexPath.row].user;
    [cell updateCommentLabel:textFrame text:text];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_cell.delegate respondsToSelector:@selector(onClickCommentViewWithCell:)]) {
        [_cell.delegate onClickCommentViewWithCell:_cell];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [_layout.topCommentCellHeights[indexPath.row] integerValue];
    return height;
}



@end
