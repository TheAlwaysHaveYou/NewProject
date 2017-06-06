//
//  ClockNumberController.m
//  NewProject
//
//  Created by fan on 17/5/16.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "ClockNumberController.h"

@interface ClockNumberController ()

@end

@implementation ClockNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self GCDTest];
    
}

- (void)GCDTest {
    //朱队列  串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"第一个");
    });
    dispatch_async(mainQueue, ^{
        NSLog(@"第二个");
    });
    dispatch_async(mainQueue, ^{
        NSLog(@"第三个");
    });
    
    //全局队列 随机执行
    dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(defaultQueue, ^{
        NSLog(@"1111");
    });
    dispatch_async(defaultQueue, ^{
        NSLog(@"2222");
    });
    dispatch_async(defaultQueue, ^{
        NSLog(@"3333");
    });
    dispatch_async(defaultQueue, ^{
        NSLog(@"4444");
    });
    
    //创建自定义队列   DISPATCH_QUEUE_SERIAL或NULL是串行队列       DISPATCH_QUEUE_CONCURRENT是并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("char类型字符串", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"4");
        dispatch_sync(concurrentQueue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"5");
        });
        NSLog(@"6");
    });
    
    //一个一个执行,前一个执行完了再下一个
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"qqqqqqqqqq");
    });
    dispatch_async(queue, ^{
        NSLog(@"wwwwwwwwww");
        [NSThread sleepForTimeInterval:3];
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"eeeeeeeeee");
    });
    
    
    dispatch_queue_t gruopQueue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, gruopQueue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"组里第一个方法");
    });
    dispatch_group_async(group, gruopQueue, ^{
        NSLog(@"组里第二个方法");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"并发队列执行完毕");
    });
    
    for (NSInteger i = 0; i < 2; i ++) {
        dispatch_apply(5, concurrentQueue, ^(size_t i) {
            NSLog(@"for循环 ----- what (%zu)",i);
        });
    }
    
}

@end
