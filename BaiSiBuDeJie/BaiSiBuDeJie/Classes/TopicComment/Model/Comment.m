//
//  Comment.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "Comment.h"
#import "NSString+Size.h"

@implementation Comment
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"commentId" : @"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"precmts" : [Comment class],
             };
}

- (CGFloat)commentCellHeight {
    if (_commentCellHeight == 0) {
        CGFloat commentCellMargin = 10;
        CGFloat avatarHeight = 35;
        // 评论内容
        CGFloat contentViewWidth = kScreenWidth - avatarHeight - 3 * commentCellMargin;
        CGFloat contentViewX = avatarHeight + commentCellMargin * 2;
        CGFloat contentViewY = avatarHeight + commentCellMargin * 2;
        
        // 楼中楼
        CGFloat y = 0;
        if (self.precmts.count > 0) {
            CGFloat relpyCommentViewHeight = 0;
            NSMutableArray *cellHeightArray = [NSMutableArray arrayWithCapacity:self.precmts.count];
            NSMutableArray *contentLabelFrameArray = [NSMutableArray arrayWithCapacity:self.precmts.count];
            NSMutableArray *contentImageViewFrameArray = [NSMutableArray arrayWithCapacity:self.precmts.count];
            NSMutableArray *contentViewFrameArray = [NSMutableArray arrayWithCapacity:self.precmts.count];
            CGFloat floorY = 0;
            for (Comment *comment in self.precmts) {
                
                CGRect imageViewFrame = CGRectZero;
                CGRect contentLabelFrame = CGRectZero;
                if (comment.image) {
                    imageViewFrame = CGRectMake(0, floorY, 110, 110);
                    floorY += imageViewFrame.size.height + commentCellMargin;
                }else {
                    imageViewFrame = CGRectZero;
                }
                
                NSString *content = comment.content;
                if (content.length > 0) {
                    CGSize floorContentTextSize = [content textSizeWithFont:[UIFont systemFontOfSize:kTopicCellTextFontSize] maxSize:CGSizeMake(contentViewWidth - 28 * 2, CGFLOAT_MAX)];
                    contentLabelFrame = CGRectMake(0, floorY, floorContentTextSize.width, floorContentTextSize.height);
                    floorY += contentLabelFrame.size.height;
                }else {
                    contentLabelFrame = CGRectZero;
                }
                
                CGRect contentViewFrame = CGRectMake(28, [UIFont systemFontOfSize:kTopicCellTextFontSize].lineHeight + 2 * commentCellMargin, contentViewWidth - 28, floorY);
                
                CGFloat cellHight = CGRectGetMaxY(contentViewFrame) + commentCellMargin;
                
                relpyCommentViewHeight += cellHight;
                [contentViewFrameArray addObject:[NSValue valueWithCGRect:contentViewFrame]];
                [cellHeightArray addObject:@(cellHight)];
                [contentLabelFrameArray addObject:[NSValue valueWithCGRect:contentLabelFrame]];
                [contentImageViewFrameArray addObject:[NSValue valueWithCGRect:imageViewFrame]];
                
            }
            _commentFloorContentViewFrames = contentViewFrameArray.copy;
            _commentFloorCellHeights = cellHeightArray.copy;
            _commentFloorContentLabelFrames = contentLabelFrameArray.copy;
            _commentFloorImageViewFrames = contentImageViewFrameArray.copy;
            
            _relpyCommentViewFrame = CGRectMake(0, y, contentViewWidth, relpyCommentViewHeight);
            y += _relpyCommentViewFrame.size.height + commentCellMargin;
        }else {
            _relpyCommentViewFrame = CGRectZero;
        }
        
        // 评论文字
        if (self.content.length > 0) {
            CGSize contentTextSize = [self.content textSizeWithFont:[UIFont systemFontOfSize:kTopicCellTextFontSize] maxSize:CGSizeMake(contentViewWidth, CGFLOAT_MAX)];
            _contentLabelFrame = CGRectMake(0, y, contentTextSize.width, contentTextSize.height);
            y += _contentLabelFrame.size.height + commentCellMargin;

        }else {
            _contentLabelFrame = CGRectZero;
        }
        
        // 评论图片
        if (self.image) {
            _contentImageViewFrame = CGRectMake(0, y, 110, 110);
            y += _contentImageViewFrame.size.height + commentCellMargin;
        }else {
            _contentImageViewFrame = CGRectZero;
        }
        
        // 评论内容
        _contentViewFrame = CGRectMake(contentViewX, contentViewY, contentViewWidth, y);
        
        // 评论Cell总高度
        _commentCellHeight = CGRectGetMaxY(_contentViewFrame) + commentCellMargin;
        NSLog(@"%.2f",_commentCellHeight);
    }
    
    return _commentCellHeight;
}

- (void)layoutCommentFloorCell {
    
    
}

@end
