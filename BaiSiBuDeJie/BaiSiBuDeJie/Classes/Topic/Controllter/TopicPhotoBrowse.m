//
//  TopicPhotoBrowse.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/23.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicPhotoBrowse.h"
#import "Topic.h"

@interface TopicPhotoBrowse ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *photoView;
@property (nonatomic, strong) UIImageView *picture;

@end

@implementation TopicPhotoBrowse

- (UIScrollView *)photoView {
    if (!_photoView) {
        _photoView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _photoView.delegate = self;
    }
    return _photoView;
}

- (UIImageView *)picture {
    if (!_picture) {
        _picture = [[UIImageView alloc] init];
        _picture.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _picture;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [self setupPhotoView];
    [self setupButtons];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _photoView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _photoView.scrollIndicatorInsets = _photoView.contentInset;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@",NSStringFromCGRect(self.photoView.frame));
    NSLog(@"%@",NSStringFromUIEdgeInsets(self.photoView.contentInset));
    NSLog(@"%@",NSStringFromCGPoint(self.photoView.contentOffset));
    [self showImageView];
}



- (void)setupPhotoView {
    
    [self.photoView addSubview:self.picture];
    [self.view addSubview:self.photoView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.photoView addGestureRecognizer:tap];
}

- (void)setupButtons {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"show_image_back_icon_30x30_"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    backBtn.frame = CGRectMake(15, 40, backBtn.frame.size.width, backBtn.frame.size.height);
    [backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat height = 35;
    CGFloat margin = 10;
    CGFloat y = self.view.frame.size.height - height - 15;
    UIButton *saveButton = [self buttonWithImageName:nil title:@"保存" action:@selector(savePicture)];
    saveButton.frame = CGRectMake(15, y, saveButton.width + 2 * margin, height);
    
    UIButton *commentButton = [self buttonWithImageName:@"mainCellComment_20x20_" title:[self buttonTitleWithCount:_topic.comment defaultTitle:@"评论"] action:@selector(sharePicture)];
    commentButton.frame = CGRectMake(self.view.width - commentButton.width - 2 * margin - 15, y, commentButton.width + 2 * margin, height);
    
    UIButton *shareButton = [self buttonWithImageName:@"showbig-share-icon_25x23_" title:[self buttonTitleWithCount:_topic.forward defaultTitle:@"分享"] action:@selector(pushCommentVC)];
    shareButton.frame = CGRectMake(commentButton.left - shareButton.width - 2 * margin - 15, y, shareButton.width + 2 * margin, height);

    [self.view addSubview:backBtn];
    [self.view addSubview:saveButton];
    [self.view addSubview:commentButton];
    [self.view addSubview:shareButton];
}

- (NSString *)buttonTitleWithCount:(NSInteger)count defaultTitle:(NSString *)title{
    if (count <= 0) {
        return title;
    }
    if (count > 9999) {
        return [NSString stringWithFormat:@"%ld万",count / 10000];
    }
    return [NSString stringWithFormat:@"%ld",count];
    
}

- (UIButton *)buttonWithImageName:(NSString *)imageName title:(NSString *)title action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = RGBA(108, 108, 108, 0.8);
    button.layer.cornerRadius = 2.0;
    button.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [button sizeToFit];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)showImageView {
    
    self.picture.image = _fromView.image;
    
    [self.photoView addSubview:self.picture];
    
    CGRect thumbViewFrame = [_fromView convertRect:_fromView.bounds toView:[UIApplication sharedApplication].keyWindow];
    self.picture.frame = thumbViewFrame;
    
    
    CGFloat imageWidth = _picture.image.size.width;
    CGFloat imageHeight = _picture.image.size.height;
    
    CGFloat targetWidth = _photoView.frame.size.width;
    CGFloat targetHeight = imageHeight * targetWidth / imageWidth;;
    CGFloat targetX = 0;
    CGFloat targetY = 0;
    if (targetHeight > _photoView.frame.size.height) {
        targetY = 0;
    }else {
        targetY = (_photoView.frame.size.height - targetHeight) * 0.5;
        
    }
    
    BOOL animate = YES;
    CGRect targetFrame = CGRectMake(targetX, targetY, targetWidth, targetHeight);
    if (targetHeight > _photoView.frame.size.height) {
        animate = NO;
    }
    
    if (animate) {
        [UIView animateWithDuration:0.25 animations:^{
            _picture.frame = targetFrame;
            _photoView.backgroundColor = [UIColor blackColor];
        } completion:^(BOOL finished) {
        }];
    }else {
        _photoView.backgroundColor = [UIColor blackColor];
        _picture.frame = targetFrame;
    }
    
    
    _photoView.contentSize = CGSizeMake(targetWidth, targetHeight);
}

- (void)dismiss {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_picture];
    CGRect imageOriginFrame = [_fromView convertRect:_fromView.bounds toView:window];
    if (_picture.frame.size.height > [UIScreen mainScreen].bounds.size.height) {
        _picture.frame = [UIScreen mainScreen].bounds;
    }
    _fromView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _picture.alpha = 0;
        _picture.frame = imageOriginFrame;
    } completion:^(BOOL finished) {
        [_picture removeFromSuperview];
        _fromView.userInteractionEnabled = YES;
    }];

}

- (void)savePicture {
    
}

- (void)sharePicture {
    
}

- (void)pushCommentVC {
    
}

@end
