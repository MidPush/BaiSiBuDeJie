//
//  CommentViewController.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/26.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "BaseRefreshViewController.h"

@class TopicLayout;
@interface CommentViewController : BaseRefreshViewController
@property (nonatomic, strong) TopicLayout *layout;
@property (nonatomic, assign, getter=isNeedContentOffset) BOOL needContentOffset;
@end
