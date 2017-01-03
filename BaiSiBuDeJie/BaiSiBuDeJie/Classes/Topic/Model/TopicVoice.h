//
//  TopicVoice.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/30.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicVoice : NSObject
@property (nonatomic, strong) NSArray *audio; // 声音URL
@property (nonatomic, strong) NSArray *download_url;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger playcount;
@property (nonatomic, assign) NSInteger playfcount;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, strong) NSArray *thumbnail;
@property (nonatomic, strong) NSArray *thumbnail_small;
@property (nonatomic, strong) NSArray *video;
@end
