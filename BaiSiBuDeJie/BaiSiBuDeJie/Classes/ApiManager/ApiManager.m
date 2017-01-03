//
//  ApiManager.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/21.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "ApiManager.h"
#import "ApiDefine.h"
#import <AFNetworking.h>

@implementation ApiManager
+ (AFHTTPSessionManager *)createManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
//        AFJSONResponseSerializer *resp = (AFJSONResponseSerializer *)manager.responseSerializer;
//        resp.removesKeysWithNullValues = YES;
        
    });
    return manager;
}


+ (void)Get:(NSString *)url parameters:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure {
    
    [[self createManager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        BSLog(@"Get Operation success, url:%@, params:%@, response=%@", url, params, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
        BSLog(@"Get Operation Failed,url:%@, params:%@, detail=%@",url,params,error);
    }];
    
}


+ (void)Post:(NSString *)url parameters:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure {
    
    [[self createManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
        
        BSLog(@"Post Operation success, url:%@, params:%@, response=%@", url, params, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
        BSLog(@"Post Operation Failed,url:%@, params:%@, detail=%@",url,params,error.description);
    }];
}

@end
