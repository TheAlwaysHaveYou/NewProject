//
//  FKD.m
//  NewProject
//
//  Created by 范魁东 on 2018/9/20.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "FKD.h"
#import <objc/runtime.h>

@implementation FKD

static NSMutableDictionary *map = nil;

- (void)asdfasdfadsfafa:(NSInteger)originNumber {
    NSString *str = [@(originNumber) stringValue];
    
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:str.length];
    for (int i = str.length - 1; i >=0 ; i --) {
        unichar ch = [str characterAtIndex:i];
        [newString appendFormat:@"%c", ch];
    }
    
    NSString *finalStr = [NSString stringWithFormat:@"%d",originNumber];
    
}

+ (void)load {
    map = [NSMutableDictionary dictionary];
    map[@"name1"]                = @"name1";
    map[@"name2"]              = @"name2";
    map[@"status1"]                = @"status1";
    map[@"status2"]              = @"status2";
}
- (void)setDataDic:(NSDictionary *)dic {
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *propertyKey = key;
        if (propertyKey) {
            objc_property_t property = class_getProperty([self class], propertyKey.UTF8String);
            //特殊数据类型的处理
            NSString *attribureString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            
            [self setValue:obj forKey:propertyKey];
        }
    }];
    
    
    
}

@end
