//
//  FKDMethodB.m
//  NewProject
//
//  Created by 范魁东 on 2018/8/21.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "FKDMethodB.h"

@interface FKDMethodB ()<FKDMethodBProcotol>

@end

@implementation FKDMethodB

- (void)todoBMethodWithName:(NSString *)methodName {
    NSLog(@"B---传递的参数---%@",methodName);
}

@end
