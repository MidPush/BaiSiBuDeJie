//
//  PublishItem.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/28.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PublishItem;
@protocol PublishItemDelegate <NSObject>
- (void)composeItemTapped:(PublishItem *)composeItem;
@end

@interface PublishItem : UIView
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithItemIcon:(NSString *)imageName title:(NSString *)title;
@property (nonatomic, weak) id <PublishItemDelegate> delegate;
@end
