//
//  TopicPicture.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicPicture : NSObject
@property (nonatomic, strong) NSArray *big;
@property (nonatomic, strong) NSArray *medium;
@property (nonatomic, strong) NSArray *small;
@property (nonatomic, strong) NSArray *thumbnail_small;
@property (nonatomic, strong) NSArray *download_url;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;

@end
