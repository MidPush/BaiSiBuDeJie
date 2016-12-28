//
//  TopicHotCommentCell.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicHotCommentCell.h"
#import "TopicCell.h"
#import "User.h"
#import "NSString+Size.h"

@interface TopicHotCommentCell (){
    BOOL _targetTouch;
}

@property (nonatomic, strong) UILabel *commentLabel;
@end

@implementation TopicHotCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.numberOfLines = 0;
        _commentLabel.font = [UIFont systemFontOfSize:kTopicCellCommentFontSize];
        [self.contentView addSubview:_commentLabel];
    }
    return self;
}

- (void)updateCommentLabel:(CGRect)frame text:(NSMutableAttributedString *)text {
    _commentLabel.frame = frame;
    _commentLabel.attributedText = text;
}

-(CGRect)userNameBounds {
    NSString *userName = self.user.name;
    CGSize size = [userName textSizeWithFont:[UIFont systemFontOfSize:kTopicCellCommentFontSize] maxSize:CGSizeMake(self.width, self.height)];
    return CGRectMake(0, 0, size.width, size.height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _targetTouch = NO;
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:_commentLabel];
    if (CGRectContainsPoint([self userNameBounds], touchPoint)) {
        _targetTouch = YES;
    }
    if (!_targetTouch) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_targetTouch) {
        [super touchesCancelled:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_targetTouch) {
        [super touchesEnded:touches withEvent:event];
    }else {
        if ([_topicCell.delegate respondsToSelector:@selector(onClickCommentUserName:)]) {
            [_topicCell.delegate onClickCommentUserName:self.user];
        }
    }
}


@end
