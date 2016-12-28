//
//  CommentFloorCellContentView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "CommentFloorCellContentView.h"
#import "Comment.h"
#import "UIImageView+WebCache.h"

@interface CommentFloorCellContentView ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *contentImageView;
@end
@implementation CommentFloorCellContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    
    //
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:kTopicCellTextFontSize];
    _contentLabel.textColor = kTopicCellTextColor;
    _contentLabel.numberOfLines = 0;
    
    //
    _contentImageView = [[UIImageView alloc] init];
    
    [self addSubview:_contentLabel];
    [self addSubview:_contentImageView];
}

- (void)setComment:(Comment *)comment contentLabelFrame:(CGRect)contentLabelFrame contentImageViewFrame:(CGRect)contentImageViewFrame {
    
        
        //
        _contentLabel.frame = contentLabelFrame;
        _contentLabel.text = comment.content;
        
        //
        _contentImageView.frame = contentImageViewFrame;
        if (comment.image) {
            [_contentImageView sd_setImageWithURL:[NSURL URLWithString:comment.image.thumbnail[0]] placeholderImage:RGB(233, 233, 233).pureColorImage];
        }
    
}


@end
