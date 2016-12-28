//
//  NSDictionary+Property.m
//  字典转模型
//
//  Created by zhong on 16/9/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "NSDictionary+Property.h"

@implementation NSDictionary (Property)

- (void)createPropertyCode {
    
    
    NSMutableString *codes = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        //NSLog(@"%@",[value class]);
        NSString *code;
        if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        }else if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }else if ([value isKindOfClass:[NSNumber class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        }else if ([value isKindOfClass:[NSArray class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        }else if ([value isKindOfClass:[NSDictionary class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }
        
        [codes appendFormat:@"\n%@\n",code];
    }];
    
    NSLog(@"%@",codes);
}

@end
