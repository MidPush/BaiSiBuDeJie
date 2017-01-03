//
//  ProfileInfo.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/30.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileInfo : NSObject
@property (nonatomic, copy) NSString *background_image;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger credit;
@property (nonatomic, assign) NSInteger experience;
@property (nonatomic, assign) NSInteger fans_count;
@property (nonatomic, assign) NSInteger follow_count;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, assign) BOOL is_vip;
@property (nonatomic, assign) BOOL jie_v;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger praise_count;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *profile_image_large;
@property (nonatomic, assign) NSInteger relationship;
@property (nonatomic, copy) NSString *room_icon;
@property (nonatomic, copy) NSString *room_name;
@property (nonatomic, copy) NSString *room_role;
@property (nonatomic, copy) NSString *room_url;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign) NSInteger share_count;
@property (nonatomic, assign) BOOL sina_v;
@property (nonatomic, assign) NSInteger tiezi_count;
@property (nonatomic, copy) NSString *total_cmt_like_count;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *v_desc;
@end
