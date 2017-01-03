//
//  ProfileHeaderView.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/30.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProfileInfo;
@interface ProfileHeaderView : UIView
+ (instancetype)headerView;
@property (nonatomic, strong) ProfileInfo *profileInfo;
@end
