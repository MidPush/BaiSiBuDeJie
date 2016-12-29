//
//  BSActionSheet.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/28.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BSActionSheet.h"

#define kButtonHeight 44
@implementation BSActionSheet {
    NSArray *_titles;
    NSString *_cancelButtonTitle;
    UIControl *_backgroundView;
    UIView *_buttonContainerView;
}


- (instancetype)initWithTitles:(NSArray *)titles delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        _titles = titles.copy;
        _cancelButtonTitle = cancelButtonTitle.copy;
        self.delegate = delegate;
        [self _initFace];
    }
    return self;
}

- (void)_initFace {
    _backgroundView = [[UIControl alloc] init];
    _backgroundView.frame = self.bounds;
    _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [_backgroundView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backgroundView];
    
#pragma mark - _buttonContainerView应该是个UITableView，当button个数太多用UiView会有问题
    _buttonContainerView = [[UIView alloc] init];
    _buttonContainerView.backgroundColor = kBaseViewHighlightColor;
    [self addSubview:_buttonContainerView];
    
    for (NSInteger i = 0; i < _titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:kBaseViewHighlightColor.pureColorImage forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, i * (kButtonHeight + 1 / [UIScreen mainScreen].scale), kScreenWidth, kButtonHeight);
        [_buttonContainerView addSubview:button];
    }
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.tag = _titles.count;
    cancelButton.backgroundColor = [UIColor whiteColor];
    [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:kBaseViewHighlightColor.pureColorImage forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(0, _titles.count * (kButtonHeight + 1 / [UIScreen mainScreen].scale) + 5, kScreenWidth, kButtonHeight);
    [_buttonContainerView addSubview:cancelButton];
    
    CGFloat containerViewH = CGRectGetMaxY(cancelButton.frame);
    _buttonContainerView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, containerViewH);
}

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(bs_actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate bs_actionSheet:self clickedButtonAtIndex:button.tag];
    }
    [self dismiss];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _backgroundView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundView.alpha = 0.5;
        _buttonContainerView.transform = CGAffineTransformMakeTranslation(0, -_buttonContainerView.frame.size.height);
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundView.alpha = 0;
        _buttonContainerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
