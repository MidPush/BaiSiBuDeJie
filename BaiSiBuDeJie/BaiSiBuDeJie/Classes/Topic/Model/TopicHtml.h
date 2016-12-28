//
//  TopicHtml.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicHtml : NSObject
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *source_url;
@property (nonatomic, strong) NSArray *thumbnail;
@property (nonatomic, strong) NSArray *thumbnail_small;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger playcount;
@property (nonatomic, assign) NSInteger playfcount;
@end
