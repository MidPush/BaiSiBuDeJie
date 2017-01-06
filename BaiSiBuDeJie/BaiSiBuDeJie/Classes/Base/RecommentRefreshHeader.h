//
//  RecommentRefreshHeader.h
//  BaiSiBuDeJie
//
//  Created by zhong on 17/1/4.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface RecommentRefreshHeader : MJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end
