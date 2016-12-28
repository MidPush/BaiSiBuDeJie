//
//  TopicGifPicture.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicGifPicture : NSObject
@property (nonatomic, strong) NSArray *download_url;
@property (nonatomic, strong) NSArray *gif_thumbnail;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@end
