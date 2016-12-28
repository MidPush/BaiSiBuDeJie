//
//  CommentImage.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentImage : NSObject
@property (nonatomic, strong) NSArray *download;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *thumbnail;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@end
