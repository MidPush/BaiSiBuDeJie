//
//  ApiManager.h
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestSuccess)(id responseObject);
typedef void (^RequestFailure)(NSError *error);

@interface ApiManager : NSObject
/**
 GET请求
 
 @param url URL路径
 @param params 请求参数
 @param success 请求成功后回调
 @param failure 请求失败后回调
 */

+ (void)Get:(NSString *)url parameters:(NSDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure;


/**
 POST请求
 
 @param url URL路径
 @param params 请求参数
 @param success 请求成功后回调
 @param failure 请求失败后回调
 */

+ (void)Post:(NSString *)url parameters:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;
@end
