//
//  TopicPictureView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicPictureView.h"
#import "TopicLayout.h"
#import "UIImageView+WebCache.h"

#import "TopicPhotoBrowse.h"

@interface TopicPictureView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *placeholder;
@property (nonatomic, strong) UIButton *seeBigPictureButton;
@property (nonatomic, strong) UIImageView *gifIcon;
@property (nonatomic, strong) UILabel *readCountLabel;

@end

@implementation TopicPictureView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _placeholder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageBackground_75x15_"]];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureTapped:)];
        [_imageView addGestureRecognizer:tap];
        
        _gifIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common-gif_31x31_"]];
        _gifIcon.hidden = YES;
        
        _seeBigPictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seeBigPictureButton setTitle:@"点击查看全图" forState:UIControlStateNormal];
        [_seeBigPictureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_seeBigPictureButton setImage:[UIImage imageNamed:@"see-big-picture_19x19_"] forState:UIControlStateNormal];
        [_seeBigPictureButton setBackgroundImage:[UIImage imageNamed:@"see-big-picture-background_285x43_"] forState:UIControlStateNormal];
        _seeBigPictureButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _seeBigPictureButton.userInteractionEnabled = NO;
        
        _seeBigPictureButton.hidden = YES;
        
        _readCountLabel = [[UILabel alloc] init];
        _readCountLabel.font = [UIFont systemFontOfSize:14];
        _readCountLabel.textColor = [UIColor whiteColor];
        _readCountLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _readCountLabel.hidden = YES;
        
        [self addSubview:_placeholder];
        [self addSubview:_imageView];
        [self addSubview:_seeBigPictureButton];
        [self addSubview:_gifIcon];
        [self addSubview:_readCountLabel];
    }
    return self;
}

- (void)setLayout:(TopicLayout *)layout {
    
    _layout = layout;
    
    _readCountLabel.frame = layout.readCountLabelFrame;
    _placeholder.frame = layout.placeholderFrame;
    _imageView.frame = layout.imageViewFrame;
    _seeBigPictureButton.frame = layout.seeBigPictureBtnFrame;
    
    
    if (_layout.isHtmlPicture) {
        _readCountLabel.hidden = NO;
         _readCountLabel.text = [NSString stringWithFormat:@"%ld阅读",layout.topic.html.playfcount];
        _seeBigPictureButton.hidden = NO;
        _seeBigPictureButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_seeBigPictureButton setTitle:@"阅读原文" forState:UIControlStateNormal];
        [_seeBigPictureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_seeBigPictureButton setImage:[UIImage imageNamed:@"link_post_icon_15x15_"] forState:UIControlStateNormal];
        [_seeBigPictureButton setBackgroundImage:nil forState:UIControlStateNormal];
    }else {
        _readCountLabel.hidden = YES;
        if (_layout.isLongPicture) {
            _seeBigPictureButton.hidden = NO;
            _seeBigPictureButton.backgroundColor = [UIColor clearColor];
            [_seeBigPictureButton setTitle:@"点击查看全图" forState:UIControlStateNormal];
            [_seeBigPictureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_seeBigPictureButton setImage:[UIImage imageNamed:@"see-big-picture_19x19_"] forState:UIControlStateNormal];
            [_seeBigPictureButton setBackgroundImage:[UIImage imageNamed:@"see-big-picture-background_285x43_"] forState:UIControlStateNormal];
        }else {
            _seeBigPictureButton.hidden = YES;
        }
    }
    
    if (layout.isGifPicture) {
        _gifIcon.hidden = NO;
    }else {
        _gifIcon.hidden = YES;
    }
    
    NSString *urlStr = nil;
    if (layout.isGifPicture) {
        urlStr = layout.topic.gif.images[0];
    }else if(layout.isPicture) {
        urlStr = layout.topic.image.download_url[0];
    }else if (layout.isHtmlPicture) {
        urlStr = layout.topic.html.thumbnail[0];
       
    }
    
    _imageView.userInteractionEnabled = NO;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            _imageView.userInteractionEnabled = YES;
            
            if (layout.isLongPicture) {
                CGFloat width = image.size.width;
                CGFloat height = image.size.height;
                _imageView.contentMode = UIViewContentModeScaleToFill;
                _imageView.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
                
            }else {
                _imageView.contentMode = UIViewContentModeScaleAspectFill;
                _imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
            }
        }
        
    }];

}


- (void)pictureTapped:(UITapGestureRecognizer *)tap {
    TopicPhotoBrowse *browse = [[TopicPhotoBrowse alloc] init];
    browse.topic = _layout.topic;
    browse.fromView = (UIImageView *)tap.view;
    
    UITabBarController *rootVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = rootVc.childViewControllers[0];
    [nav presentViewController:[[UINavigationController alloc] initWithRootViewController:browse] animated:NO completion:^{
        
    }];
    
}


@end
