//
//  TopicLayout.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicLayout.h"
#import "NSString+Size.h"
#import "NSMutableAttributedString+RichText.h"

@implementation TopicLayout
- (instancetype)initWithTopic:(Topic *)topic {
    if (self = [super init]) {
        _topic = topic;
        [self layout];
    }
    return self;
}

- (void)reloadLayoutForLongText {
    _isShowLongText = !_isShowLongText;
    NSString *text = _topic.text;
    if (_topic.html) {
        text = _topic.html.desc;
    }
    UIFont *font = [UIFont systemFontOfSize:kTopicCellTextFontSize];
    CGSize textMaxSize = CGSizeMake(kScreenWidth - 2 * kTopicCellCellMargin, CGFLOAT_MAX);
    CGSize textSize = [text textSizeWithFont:font maxSize:textMaxSize];
    CGFloat height = (textSize.height - font.lineHeight * 7);
    if (_isShowLongText) {
        _textFrame.size.height += height;
        _longTextButtonFrame.origin.y += height;
        if (_isVoice) {
            _voiceContainerFrame.origin.y += height; // 声音帖子文字也存在长文字，其他帖子暂没发现
        }
        _toolBarFrame.origin.y += height;
        _hotCommentViewFrame.origin.y += height;
        _topicCellHeight += height;
    }else {
        _textFrame.size.height -= height;
        _longTextButtonFrame.origin.y -= height;
        if (_isVoice) {
            _voiceContainerFrame.origin.y -= height; // 声音帖子文字也存在长文字，其他帖子暂没发现
        }
        _toolBarFrame.origin.y -= height;
        _hotCommentViewFrame.origin.y -= height;
        _topicCellHeight -= height;
    }
}

- (void)layout {
    
    // 分割线
    _separatorFrame = CGRectMake(0, 0, kScreenWidth, 8);
    
    // 头像
    _avatarFrame = CGRectMake(kTopicCellCellMargin, kTopicCellCellMargin, kTopicCellAvatarWidth, kTopicCellAvatarWidth);
    
    // Badge
    _avatarBadgeFrame = CGRectMake(CGRectGetMaxX(_avatarFrame) - 14, CGRectGetMaxY(_avatarFrame) - 14, 14, 14);
    
    // 昵称
    NSString *name = _topic.user.name;
    CGSize nameMaxSize = CGSizeMake(kScreenWidth - CGRectGetMaxX(_avatarFrame) - 2 * kTopicCellCellMargin, 30);
    CGSize nameTextSize = [name textSizeWithFont:[UIFont systemFontOfSize:kTopicCellNameFontSize] maxSize:nameMaxSize];
    _nameFrame = CGRectMake(CGRectGetMaxX(_avatarFrame) + kTopicCellCellMargin, kTopicCellCellMargin, nameTextSize.width, nameTextSize.height);
    
    // vipIcon
    _vipIconFrame = CGRectMake(CGRectGetMaxX(_nameFrame) + 5, kTopicCellCellMargin + 2, 16, 12);
    
    // 时间
    NSString *time = _topic.passtime;
    CGSize timeMaxSize = CGSizeMake(kScreenWidth - CGRectGetMaxX(_avatarFrame) - 2 * kTopicCellCellMargin, 14);
    CGSize timeTextSize = [time textSizeWithFont:[UIFont systemFontOfSize:kTopicCellNameFontSize] maxSize:timeMaxSize];
    _timeFrame = CGRectMake(CGRectGetMinX(_nameFrame), CGRectGetMaxY(_nameFrame) + 5, timeTextSize.width, timeTextSize.height);
    
    // 用户个人资料
    _profileFrame = CGRectMake(0, CGRectGetMaxY(_separatorFrame), kScreenWidth, MAX(CGRectGetMaxY(_avatarFrame), CGRectGetMaxY(_timeFrame)));
    
    
    // 帖子文字
    NSString *text = _topic.text;
    if (_topic.html) {
        text = _topic.html.desc;
    }
    UIFont *font = [UIFont systemFontOfSize:kTopicCellTextFontSize];
    CGSize textMaxSize = CGSizeMake(kScreenWidth - 2 * kTopicCellCellMargin, CGFLOAT_MAX);
    CGSize textSize = [text textSizeWithFont:font maxSize:textMaxSize];
    _textFrame = CGRectMake(kTopicCellCellMargin, CGRectGetMaxY(_profileFrame) + kTopicCellCellMargin, textSize.width, textSize.height);
    if(textSize.height > font.lineHeight * 7) {
        self.isLongText = YES;
        CGSize size = [@"全文" textSizeWithFont:font maxSize:textMaxSize];
        _longTextButtonFrame = CGRectMake(kTopicCellCellMargin, CGRectGetMinY(_textFrame) + font.lineHeight * 7, size.width, size.height);
        _textFrame = CGRectMake(kTopicCellCellMargin, CGRectGetMaxY(_profileFrame) + kTopicCellCellMargin, textSize.width, font.lineHeight * 7);
    }else {
        self.isLongText = NO;
        _longTextButtonFrame = CGRectZero;
    }
    
    // 图片
    if (_topic.image || _topic.gif || _topic.html) {
        self.isVideo = NO;
        self.isVoice = NO;
        NSInteger imageWidth = 0;
        NSInteger imageHeight = 0;
        if (_topic.image) {
            self.isPicture = YES;
            self.isHtmlPicture = NO;
            self.isGifPicture = NO;
            imageWidth = _topic.image.width;
            imageHeight = _topic.image.height;
        }else if(_topic.gif) {
            self.isPicture = NO;
            self.isHtmlPicture = NO;
            self.isGifPicture = YES;
            imageWidth= _topic.gif.width;
            imageHeight = _topic.gif.height;
        }else if (_topic.html) {
            self.isPicture = NO;
            self.isHtmlPicture = YES;
            self.isGifPicture = NO;
            imageWidth= kScreenWidth - 2 * kTopicCellCellMargin;
            imageHeight = 150;
            CGSize readCountLabelSize = [[NSString stringWithFormat:@"%ld阅读",_topic.html.playfcount] textSizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(150, 30)];
            _readCountLabelFrame = CGRectMake(imageWidth - readCountLabelSize.width, 0, readCountLabelSize.width, readCountLabelSize.height);
        }
        
        CGFloat pictureW = kScreenWidth - 2 * kTopicCellCellMargin;
        CGFloat pictureH = imageHeight * pictureW / imageWidth;
        if (pictureH > 400) { // 长图
            pictureH = 300;
            self.isLongPicture = YES;
        }else {
            self.isLongPicture = NO;
        }
        _pictureContainerFrame = CGRectMake(kTopicCellCellMargin, CGRectGetMaxY(_textFrame) + kTopicCellCellMargin, pictureW, pictureH);
        _imageViewFrame = CGRectMake(0, 0, pictureW, pictureH);
        _placeholderFrame = CGRectMake((pictureW - 150) / 2, kTopicCellCellMargin, 150, 30);
        _seeBigPictureBtnFrame = CGRectMake(0, pictureH - 44, pictureW, 44);
    }else {
        self.isPicture = NO;
        self.isGifPicture = NO;
        self.isHtmlPicture = NO;
        _pictureContainerFrame = CGRectZero;
        _imageViewFrame = CGRectZero;
        _placeholderFrame = CGRectZero;
        _seeBigPictureBtnFrame = CGRectZero;
    }
    
    // 视频
    if (_topic.video) {
        self.isVideo = YES;
        self.isPicture = NO;
        self.isGifPicture = NO;
        self.isLongPicture = NO;
        self.isVoice = NO;
        CGFloat videoMaxWidth = kScreenWidth - 2 * kTopicCellCellMargin;
        NSInteger videoWidth = _topic.video.width;
        NSInteger videoHeight = _topic.video.height;
        
        CGFloat videoW = kScreenWidth - 2 * kTopicCellCellMargin;
        CGFloat videoH = videoHeight * videoW / videoWidth;
        if (videoH > 300) { // 长图
            videoH = 300;
            videoW = videoWidth * videoH / videoHeight;
        }
        _videoContainerFrame = CGRectMake(kTopicCellCellMargin, CGRectGetMaxY(_textFrame) + kTopicCellCellMargin, videoMaxWidth, videoH);
        _videoImageViewFrame = CGRectMake((videoMaxWidth - videoW) / 2, 0, videoW, videoH);
        _videoPlaceholderFrame = CGRectMake((videoMaxWidth - 150) / 2, kTopicCellCellMargin, 150, 30);
        _playVideoButtonFrame = CGRectMake(0, 0, videoMaxWidth, videoH);
        
        // BottomCover
        _videoBottomCoverFrame = CGRectMake(0, videoH - 40, videoMaxWidth, 40);

        // 播放次数Label
        self.videoPlayCountText = [NSString stringWithFormat:@"%ld播放",_topic.video.playcount];

        CGSize playCountTextSize = [self.videoPlayCountText textSizeWithFont:[UIFont systemFontOfSize:kTopicCellVideoTextFontSize] maxSize:CGSizeMake(videoMaxWidth , videoH)];
        _videoPlayCountLabelFrame = CGRectMake(2, videoH - playCountTextSize.height - 2, playCountTextSize.width, playCountTextSize.height);
    
        // 视频时长Label
        self.videoTimeText = [self getFromTime:_topic.video.duration];
        CGSize timeTextSize = [self.videoTimeText textSizeWithFont:[UIFont systemFontOfSize:kTopicCellVideoTextFontSize] maxSize:CGSizeMake(videoW , videoH)];
        _videoTimeLabelFrame = CGRectMake(videoMaxWidth - timeTextSize.width -2, videoH - timeTextSize.height - 2, timeTextSize.width, timeTextSize.height);
        
    }else {
        self.isVideo = NO;
        _videoContainerFrame = CGRectZero;
        _videoImageViewFrame = CGRectZero;
        _videoPlayCountLabelFrame = CGRectZero;
        _videoTimeLabelFrame = CGRectZero;
        _videoPlaceholderFrame = CGRectZero;
        _playVideoButtonFrame = CGRectZero;
        
    }
    
    // 声音
    if (_topic.audio) {
        self.isVoice = YES;
        self.isVideo = NO;
        self.isPicture = NO;
        self.isGifPicture = NO;
        self.isLongPicture = NO;
        CGFloat voiceMaxWidth = kScreenWidth - 2 * kTopicCellCellMargin;
        NSInteger voiceWidth = _topic.audio.width;
        NSInteger voiceHeight = _topic.audio.height;
        
        CGFloat voiceW = kScreenWidth - 2 * kTopicCellCellMargin;
        CGFloat voiceH = voiceHeight * voiceW / voiceWidth;
        if (_isLongText) {
            // +8让播放按钮突出来一点
            _voiceContainerFrame = CGRectMake(kTopicCellCellMargin, CGRectGetMaxY(_longTextButtonFrame) + kTopicCellCellMargin, voiceMaxWidth, voiceH + 8);
        }else {
            _voiceContainerFrame = CGRectMake(kTopicCellCellMargin, CGRectGetMaxY(_textFrame) + kTopicCellCellMargin, voiceMaxWidth, voiceH + 8);
        }
        _voiceImageViewFrame = CGRectMake((voiceMaxWidth - voiceW) / 2, 0, voiceW, voiceH);
        _voicePlaceholderFrame = CGRectMake((voiceMaxWidth - 150) / 2, kTopicCellCellMargin, 150, 30);
        _playVoiceButtonFrame = CGRectMake((voiceMaxWidth - 63) / 2, _voiceContainerFrame.size.height - 63, 63, 63);
        
        // BottomCover
        _voiceBottomCoverFrame = CGRectMake(0, voiceH - 40, voiceMaxWidth, 40);
        
        // 播放次数Label
        self.voicePlayCountText = [NSString stringWithFormat:@"%ld播放",_topic.audio.playcount];
        
        CGSize playCountTextSize = [self.voicePlayCountText textSizeWithFont:[UIFont systemFontOfSize:kTopicCellVideoTextFontSize] maxSize:CGSizeMake(voiceMaxWidth , voiceH)];
        _voicePlayCountLabelFrame = CGRectMake(2, voiceH - playCountTextSize.height - 2, playCountTextSize.width, playCountTextSize.height);
        
        // 视频时长Label
        self.voiceTimeText = [self getFromTime:_topic.audio.duration];
        CGSize timeTextSize = [self.voiceTimeText textSizeWithFont:[UIFont systemFontOfSize:kTopicCellVideoTextFontSize] maxSize:CGSizeMake(voiceW , voiceH)];
        _voiceTimeLabelFrame = CGRectMake(voiceMaxWidth - timeTextSize.width -2, voiceH - timeTextSize.height - 2, timeTextSize.width, timeTextSize.height);
        
    }else {
        self.isVoice = NO;
    }
    
    // 工具条
    CGFloat toolBarY = CGRectGetMaxY(_textFrame);
    if (_isPicture || _isGifPicture || _isHtmlPicture) {
        toolBarY = CGRectGetMaxY(_pictureContainerFrame);
    }else if (_isVideo) {
        toolBarY = CGRectGetMaxY(_videoContainerFrame);
    }else if (_isVoice) {
        toolBarY = CGRectGetMaxY(_voiceContainerFrame);
    }else if (_isLongText) {
        toolBarY = CGRectGetMaxY(_longTextButtonFrame);
    }
    _toolBarFrame = CGRectMake(0, toolBarY, kScreenWidth, kTopicCellToolBarHeight);
    
    // 热门评论
    [self layoutHotCommentView];
    
    // TopicCell高度
    if (self.hasTopComment) {
        _topicCellHeight = CGRectGetMaxY(_hotCommentViewFrame) + kTopicCellCellMargin;
    }else {
        _topicCellHeight = CGRectGetMaxY(_toolBarFrame);
    }
}



- (void)layoutHotCommentView {
    CGFloat hotCommentViewW = kScreenWidth - 2 * kTopicCellCellMargin;
    CGFloat hotCommentTableViewH = 0;
    NSArray *topComments = _topic.top_comments;
    if (topComments.count > 0) {
        self.hasTopComment = YES;
        NSMutableArray *commentCellHeightArray = [NSMutableArray arrayWithCapacity:topComments.count];
        NSMutableArray *commentTextArray = [NSMutableArray arrayWithCapacity:topComments.count];
        NSMutableArray *commentTextFrameArray = [NSMutableArray arrayWithCapacity:topComments.count];

        NSMutableAttributedString *fullText = nil;
        for (TopicTopComment *topComment in topComments) {
            NSString *userName = topComment.user.name;
            NSString *commentText = topComment.content;
            NSString *text = [NSString stringWithFormat:@"%@:  %@",userName,commentText];
            
            
            fullText = [[NSMutableAttributedString alloc] initWithString:text];
            [fullText xz_setFont:[UIFont systemFontOfSize:kTopicCellCommentFontSize] range:NSMakeRange(0, fullText.length)];
            [fullText xz_setColor:kTopicCellCommentUserNameColor range:NSMakeRange(0, userName.length)];
            [fullText xz_setColor:kTopicCellCommentTextColor range:NSMakeRange(userName.length, fullText.length - userName.length)];
            CGSize fullTextSize = [fullText boundingRectWithSize:CGSizeMake(hotCommentViewW - 2 * kTopicCellCellMargin, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            CGRect frame = CGRectMake(kTopicCellCellMargin, 0, fullTextSize.width, fullTextSize.height);
            
            CGFloat commentCellHeight = fullTextSize.height + 5;
            [commentTextArray addObject:fullText];
            [commentCellHeightArray addObject:@(commentCellHeight)];
            [commentTextFrameArray addObject:[NSValue valueWithCGRect:frame]];
            
            // 计算热门评论View的高度
            hotCommentTableViewH += commentCellHeight;
        }
        CGFloat topMargin = 8;
        _hotCommentTableViewFrame = CGRectMake(0, topMargin, hotCommentViewW, hotCommentTableViewH);
        _topCommentCellHeights = commentCellHeightArray.copy;
        _topCommentTexts = commentTextArray.copy;
        _topCommentTextFrames = commentTextFrameArray.copy;
        
        _hotCommentViewFrame = CGRectMake(kTopicCellCellMargin, CGRectGetMaxY(_toolBarFrame), hotCommentViewW, hotCommentTableViewH + 2 * topMargin);
    }else {
        self.hasTopComment = NO;
        _hotCommentViewFrame = CGRectZero;
    }
}

-(NSString *)getFromTime:(NSInteger)totalTime{
    
    NSInteger seconds = totalTime;
    
    //format of hour
    NSString *hour = [NSString stringWithFormat:@"%02ld",seconds / 3600];
    //format of minute
    NSString *minute = [NSString stringWithFormat:@"%02ld",(seconds % 3600) / 60];
    //format of second
    NSString *second = [NSString stringWithFormat:@"%02ld",seconds % 60];
    //format of time
    if ([hour integerValue] > 0) { // 大于或等于小时
        return [NSString stringWithFormat:@"%@:%@:%@",hour,minute,second];
    }

    return [NSString stringWithFormat:@"%@:%@",minute,second];
    
}


@end
