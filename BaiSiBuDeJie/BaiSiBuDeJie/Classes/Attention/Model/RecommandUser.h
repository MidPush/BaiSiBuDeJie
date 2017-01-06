//
//  RecommandUser.h
//  BaiSiBuDeJie
//
//  Created by zhong on 17/1/4.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommandUser : NSObject
@property (nonatomic, copy) NSString *header;
@property (nonatomic, assign) BOOL is_vip;
//@property (nonatomic, assign) BOOL is_v;
@property (nonatomic, assign) BOOL is_follow;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, assign) NSInteger tiezi_count;
@property (nonatomic, assign) NSInteger fans_count;
@property (nonatomic, copy) NSString *social_name;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger plat_flag;
@property (nonatomic, copy) NSString *screen_name;
@end
