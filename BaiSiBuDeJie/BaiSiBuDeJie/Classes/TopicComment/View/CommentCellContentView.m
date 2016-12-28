//
//  CommentCellContentView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "CommentCellContentView.h"
#import "Comment.h"
#import "UIImageView+WebCache.h"
#import "CommentFloorCell.h"

@interface CommentCellContentView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *relpyCommentView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *contentImageView;
@end

static NSString *identifier = @"CommentFloorCell";
@implementation CommentCellContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    // _relpyCommentView
    _relpyCommentView = [[UITableView alloc] init];
    _relpyCommentView.delegate = self;
    _relpyCommentView.dataSource = self;
    _relpyCommentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _relpyCommentView.scrollEnabled = NO;
    [_relpyCommentView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentFloorCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
    //
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:kTopicCellTextFontSize];
    _contentLabel.textColor = kTopicCellTextColor;
    _contentLabel.numberOfLines = 0;
    
    //
    _contentImageView = [[UIImageView alloc] init];
 
    [self addSubview:_relpyCommentView];
    [self addSubview:_contentLabel];
    [self addSubview:_contentImageView];
}

- (void)setComment:(Comment *)comment {
    if (_comment != comment) {
        _comment = comment;
        
        //
        _relpyCommentView.frame = comment.relpyCommentViewFrame;
//        NSLog(@"%@",NSStringFromCGRect(_relpyCommentView.frame));
        [_relpyCommentView reloadData];
        
        //
        _contentLabel.frame = comment.contentLabelFrame;
        _contentLabel.text = comment.content;
        
        //
        _contentImageView.frame = comment.contentImageViewFrame;
        if (comment.image) {
            [_contentImageView sd_setImageWithURL:[NSURL URLWithString:comment.image.thumbnail[0]] placeholderImage:RGB(233, 233, 233).pureColorImage];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _comment.precmts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentFloorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    Comment *comment = _comment.precmts[indexPath.row];
    CGRect conentLabelFrame = [_comment.commentFloorContentLabelFrames[indexPath.row] CGRectValue];
    CGRect contentImageViewFrame = [_comment.commentFloorImageViewFrames[indexPath.row] CGRectValue];
    CGRect contentViewFrame = [_comment.commentFloorContentViewFrames[indexPath.row] CGRectValue];
    [cell setComment:comment contentLabelFrame:conentLabelFrame contentImageViewFrame:(CGRect)contentImageViewFrame contentViewFrame:contentViewFrame];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight = [_comment.commentFloorCellHeights[indexPath.row] integerValue];
    NSLog(@"%.1f",cellHeight);
    return cellHeight;
}



@end
