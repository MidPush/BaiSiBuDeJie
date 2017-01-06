//
//  RecommandCategory.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/31.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommandCategory : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSMutableArray *users;
@end
