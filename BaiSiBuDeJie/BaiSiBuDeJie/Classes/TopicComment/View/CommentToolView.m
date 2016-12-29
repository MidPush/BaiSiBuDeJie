//
//  CommentToolView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/29.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "CommentToolView.h"
#import "BSTextView.h"


@interface CommentToolView ()<UITextViewDelegate> {
    CGFloat _keyboardHeight;
}
@property (nonatomic, strong) UITabBar *toolBar;
@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) BSTextView *textView;
@property (nonatomic, strong) UIControl *backgroundView;
@end
@implementation CommentToolView

- (UIControl *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIControl alloc] init];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _backgroundView.frame = CGRectMake(0, -64, self.width, [UIScreen mainScreen].bounds.size.height);
        [_backgroundView addTarget:self action:@selector(dismissBackgroundView) forControlEvents:UIControlEventTouchUpInside];
//        _backgroundView.hidden = YES;
    }
    return _backgroundView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupToolBar];
        [self setupBottomView];
        
        [self addKeyboardNotification];
    }
    return self;
}

- (void)setupToolBar {
    _toolBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:_toolBar];
    
    CGFloat margin = 10;
    _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_voiceButton setImage:[UIImage imageNamed:@"comment-bar-voice_28x28_"] forState:UIControlStateNormal];
    [_voiceButton setImage:[UIImage imageNamed:@"comment-bar-voice-click_28x28_"] forState:UIControlStateHighlighted];
    _voiceButton.frame = CGRectMake(margin, (_toolBar.height - 28) / 2, 28, 28);
    [_voiceButton addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setImage:[UIImage imageNamed:@"comment_bar_at_icon_26x26_"] forState:UIControlStateNormal];
    [photoButton setImage:[UIImage imageNamed:@"comment_bar_at_icon_click_26x26_"] forState:UIControlStateHighlighted];
    photoButton.frame = CGRectMake(_toolBar.width - 28 - margin, (_toolBar.height - 28) / 2, 28, 28);
    [photoButton addTarget:self action:@selector(photoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _textView = [[BSTextView alloc] initWithFrame:CGRectMake(_voiceButton.right + margin, 5, _toolBar.width - _voiceButton.width - photoButton.width - 4 * margin, _toolBar.height - 2 * 5)];
    _textView.placeholder = @"写评论...";
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    _textView.delegate = self;
    [self addSubview:_voiceButton];
    [self addSubview:photoButton];
    [self addSubview:_textView];
}

- (void)setupBottomView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _toolBar.bottom, self.width, self.height - _toolBar.height)];
    view.backgroundColor = [UIColor redColor];
    [self insertSubview:view atIndex:0];
}

- (void)dismissBackgroundView {
    [_backgroundView removeFromSuperview];
    _backgroundView = nil;
    [_textView resignFirstResponder];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)voiceButtonClick {
    [_voiceButton setImage:[UIImage imageNamed:@"comment-bar-keyboard_28x28_"] forState:UIControlStateNormal];
    [_voiceButton setImage:[UIImage imageNamed:@"comment-bar-keyboard-click_28x28_"] forState:UIControlStateHighlighted];
}

- (void)photoButtonClick {
    
}

- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc {
    [self removeNotification];
}

#pragma mark - 监听键盘的弹出和隐藏
- (void)KeyboardWillShow:(NSNotification *)notification {
    if ([self.delegate respondsToSelector:@selector(commentToolViewIsEditable:)]) {
        [self.delegate commentToolViewIsEditable:YES];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.superview insertSubview:self.backgroundView belowSubview:self];
    });
    
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyboardHeight = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    _keyboardHeight = keyboardHeight;
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, self.superview.height -(keyboardHeight + _textView.height + 2 * 5), self.superview.width, keyboardHeight + _textView.height + 2 * 5);

    }];
    
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if ([self.delegate respondsToSelector:@selector(commentToolViewIsEditable:)]) {
        [self.delegate commentToolViewIsEditable:NO];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, self.superview.height - (_textView.height + 2 * 5), self.superview.width,_textView.height + 2 * 5);
    }];
}

- (void)textViewDidChange:(UITextView *)textView {

    [textView flashScrollIndicators];   // 闪动滚动条
    
    static CGFloat maxHeight = 70;
    CGSize constraintSize = CGSizeMake(textView.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height >= maxHeight)
    {
        size.height = maxHeight;
        textView.scrollEnabled = YES;   // 允许滚动
    }else {
        textView.scrollEnabled = NO;    // 不允许滚动，当textview的大小足以容纳它的text的时候，需要设置scrollEnabed为NO，否则会出现光标乱滚动的情况
    }
    textView.frame = CGRectMake(textView.left, textView.top, textView.width, size.height);
    
    if (size.height <= maxHeight) {

        [UIView animateWithDuration:0.25 animations:^{
            self.top = (self.superview.height - _keyboardHeight - _toolBar.height) - (size.height - (_toolBar.height - 2 * 5));
        }];
    }
    
}

@end
