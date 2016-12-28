//
//  PublishView.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/28.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishItem.h"

@protocol PublishViewDelegate <NSObject>
- (void)onClickPublishItem:(PublishItem *)publishItem;
@end
@interface PublishView : UIView
@property (nonatomic, weak) id <PublishViewDelegate> delegate;
@end
