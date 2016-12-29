//
//  BSTextView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/29.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BSTextView.h"

@implementation BSTextView {
    @private
    UILabel *_placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:16];
        self.placeholderColor = [UIColor grayColor];
        
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.textColor = [UIColor grayColor];
        _placeholderLabel.font = self.font;
        _placeholderLabel.numberOfLines = 0;
        
        [self addSubview:_placeholderLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textDidChange {
    if (self.text.length > 0 || self.attributedText.length > 0) {
        _placeholderLabel.hidden = YES;
    } else {
        _placeholderLabel.hidden = NO;
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeholder != placeholder) {
        _placeholder = placeholder.copy;
        _placeholderLabel.text = _placeholder;
        [self layoutIfNeeded];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat adjustX = 10;
    CGFloat adjustY = 9;
    CGSize textSize = [_placeholderLabel.text boundingRectWithSize:CGSizeMake(self.width - 2 * adjustX, self.height - 2 * adjustY) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_placeholderLabel.font} context:nil].size;
    _placeholderLabel.frame = CGRectMake(adjustX, adjustY, textSize.width, textSize.height);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    if (_placeholderColor != placeholderColor) {
        _placeholderColor = placeholderColor;
        _placeholderLabel.textColor = _placeholderColor;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
