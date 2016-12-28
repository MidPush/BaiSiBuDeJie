//
//  PublishView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/28.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "PublishView.h"
#import "pop.h"

@interface PublishView ()<PublishItemDelegate>
@property (nonatomic, strong) UIControl *backgroundView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) NSMutableArray *pulishItems;
@property (nonatomic, strong) UIImageView *sloganView;
@end

@implementation PublishView

- (NSMutableArray *)pulishItems {
    if (!_pulishItems) {
        _pulishItems = [NSMutableArray array];
    }
    return _pulishItems;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _backgroundView = [[UIControl alloc] initWithFrame:self.bounds];
        _backgroundView.enabled = NO;
        [_backgroundView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backgroundView];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.enabled = NO;
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.frame = CGRectMake(0, self.height - 40, self.width, 40);
        [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        NSArray *icons = @[@"publish-video_75x75_", @"publish-picture_75x75_", @"publish-text_75x75_", @"publish-audio_75x75_", @"publish-review_75x75_", @"publish-link_72x72_"];
        NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"发链接"];
        
        CGFloat margin = 15;
        CGFloat itemWidth = (self.width - 2 * margin) / 3;
        CGFloat itemHeight = itemWidth + 10;
        CGFloat distanceY = (self.height - 2 * itemHeight) / 2;
        for (NSInteger i = 0; i < icons.count; i++) {
            PublishItem *publishItem = [[PublishItem alloc] initWithItemIcon:icons[i] title:titles[i]];
            publishItem.delegate = self;
            CGFloat row = i / 3;
            CGFloat col = i % 3;
            CGFloat itemX = margin + col * itemWidth;
            CGFloat itemEndY = distanceY + row * itemHeight;
            CGFloat startItemY = itemEndY - self.height;
            publishItem.frame = CGRectMake(itemX, startItemY, itemWidth, itemHeight);
            [self addSubview:publishItem];
            [self.pulishItems addObject:publishItem];
            
            POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            animation.fromValue = [NSValue valueWithCGRect:CGRectMake(itemX, startItemY, itemWidth, itemHeight)];
            animation.toValue = [NSValue valueWithCGRect:CGRectMake(itemX, distanceY + row * (itemHeight + margin), itemWidth, itemHeight)];
            animation.springBounciness = 5;
            animation.springSpeed = 10;
            NSTimeInterval sort = [self itemSortWithIndex:i];
            animation.beginTime = CACurrentMediaTime() + 0.05 * sort;
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
                _backgroundView.enabled = YES;
                _cancelButton.enabled = YES;
            }];
            [publishItem pop_addAnimation:animation forKey:nil];
        }
        
        _sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan_245x25_"]];
        [self addSubview:_sloganView];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerX = kScreenWidth * 0.5;
        CGFloat centerEndY = kScreenHeight * 0.2;
        CGFloat centerBeginY = centerEndY - kScreenHeight;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
        animation.beginTime = CACurrentMediaTime() + 0.05 * 3;
        [_sloganView pop_addAnimation:animation forKey:nil];

    }
    return self;
}

- (void)dismiss {
    _backgroundView.enabled = NO;
    _cancelButton.enabled = NO;
    [_cancelButton removeFromSuperview];
    for (NSInteger i = 0; i < self.pulishItems.count; i++) {
        PublishItem *item = self.pulishItems[i];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        animation.springSpeed = 10;
        CGFloat centerY = item.centerY + kScreenHeight;
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(item.centerX, centerY)];
        NSTimeInterval sort = [self itemSortWithIndex:i];
        animation.beginTime = CACurrentMediaTime() + 0.05 * sort;
        
        if (i == 4) {
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
                [self removeFromSuperview];
            }];
        }
        [item pop_addAnimation:animation forKey:nil];
        
    }
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerY = _sloganView.centerY + kScreenHeight;
    animation.springSpeed = 10;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_sloganView.centerX, centerY)];
    animation.beginTime = CACurrentMediaTime() + 0.05 * 4;
    [_sloganView pop_addAnimation:animation forKey:nil];

}

- (NSTimeInterval)itemSortWithIndex:(NSInteger)index {
    NSTimeInterval sort;
    switch (index) {
        case 0:
            sort = 5;
            break;
        case 1:
            sort = 3;
            break;
        case 2:
            sort = 4;
            break;
        case 3:
            sort = 2;
            break;
        case 4:
            sort = 0;
            break;
        case 5:
            sort = 1;
            break;
            
        default:
            break;
    }
    return sort;
}

- (void)composeItemTapped:(PublishItem *)composeItem {
    if ([self.delegate respondsToSelector:@selector(onClickPublishItem:)]) {
        [self.delegate onClickPublishItem:composeItem];
    }
}

@end
