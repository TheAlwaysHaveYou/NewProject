//
//  FKDMethodA.m
//  NewProject
//
//  Created by 范魁东 on 2018/8/21.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "FKDMethodA.h"

@interface FKDMethodA () <FKDMethodAProtocol>

@end

@implementation FKDMethodA

- (void)todoAMethodWithName:(NSString *)methodName {
    NSLog(@"A---传递的参数---%@",methodName);
}

@end
