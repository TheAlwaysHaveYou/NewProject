//
//  FKDProxy.m
//  NewProject
//
//  Created by 范魁东 on 2018/8/21.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "FKDProxy.h"
#import <objc/runtime.h>

@interface FKDProxy()

@property (nonatomic , strong) FKDMethodA *methodA;
@property (nonatomic , strong) FKDMethodB *methodB;
@property (nonatomic , strong) NSMutableDictionary *methodsMap;

@end

@implementation FKDProxy

+ (instancetype)dealerProxy {
    //只能alloc 初始化，  没有init，需要自己写一个构造方法
    return [[FKDProxy alloc] init];
}

- (instancetype)init {
    self.methodA = [[FKDMethodA alloc] init];
    self.methodB = [[FKDMethodB alloc] init];
    self.methodsMap = [[NSMutableDictionary alloc] init];
    
    [self registerMethodsWithTarget:self.methodA];
    [self registerMethodsWithTarget:self.methodB];
    
    return self;
}

- (void)registerMethodsWithTarget:(id)target {
    unsigned int numberOfMethods = 0;
    Method *methodList = class_copyMethodList([target class], &numberOfMethods);
    
    for (int i = 0; i < numberOfMethods; i ++) {
        Method tempMethod = methodList[i];
        SEL tempSel = method_getName(tempMethod);
        const char *tempMethodName = sel_getName(tempSel);
        [self.methodsMap setObject:target forKey:[NSString stringWithUTF8String:tempMethodName]];
    }
    free(methodList);
}

//重写父类方法
- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL sel = invocation.selector;
    NSString *methodName = NSStringFromSelector(sel);
    id target = self.methodsMap[methodName];
    
    if (target && [target respondsToSelector:sel]) {
        [invocation invokeWithTarget:target];
    }else {
        [super forwardInvocation:invocation];
    }
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSString *methodName = NSStringFromSelector(sel);
    
    id target = self.methodsMap[methodName];
    if (target && [target respondsToSelector:sel]) {
        return [target methodSignatureForSelector:sel];
    }else {
        return [super methodSignatureForSelector:sel];
    }
}

@end
