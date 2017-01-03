//
//  User.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong) NSArray *header;
@property (nonatomic, assign) BOOL is_vip;
@property (nonatomic, assign) BOOL is_v;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *room_icon;
@property (nonatomic, copy) NSString *room_name;
@property (nonatomic, copy) NSString *room_role;
@property (nonatomic, copy) NSString *room_url;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *qq_uid;
@property (nonatomic, copy) NSString *qzone_uid;
@property (nonatomic, copy) NSString *weibo_uid;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *personal_page;
@property (nonatomic, copy) NSString *total_cmt_like_count;
@property (nonatomic, copy) NSString *username;



@end
