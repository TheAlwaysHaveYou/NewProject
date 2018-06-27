//
//  Person.m
//  NewProject
//
//  Created by 范魁东 on 2018/6/27.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "Person.h"

static NSString *_name;
static dispatch_queue_t _concurrentQueue;

@implementation Person

//多线程操作属性读写的时候
//既保证线程安全，又保证读写效率

- (instancetype)init {
    self = [super init];
    if (self) {
        _concurrentQueue = dispatch_queue_create("123123", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)setName:(NSString *)name {
    dispatch_barrier_async(_concurrentQueue, ^{
        _name = [name copy];
    });
}

- (NSString *)name {
    __block NSString *tempName;
    dispatch_sync(_concurrentQueue, ^{
        tempName = _name;
    });
    return tempName;
}

@end
