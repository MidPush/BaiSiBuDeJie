//
//  CommentGroup.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"

@interface CommentGroup : NSObject
@property (nonatomic, strong) NSArray <Comment *> *hot;
@property (nonatomic, strong) NSArray <Comment *> *normal;
@end
