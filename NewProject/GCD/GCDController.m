//
//  GCDController.m
//  NewProject
//
//  Created by 范魁东 on 2018/6/27.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "GCDController.h"

@interface GCDController ()

@end

@implementation GCDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //    [self firstTest];
    
    //    [self secondTest];
    
    //    [self thirdTest];
    
    //    [self fourthTest];
    
    //    [self fifthTest];
    
    //    [self sixTest];
    
    //    [self sevenTest];
    
    //    [self eightTest];
    
    [self ninthTest];
    
    //    CFunction();
}

- (void)firstTest {
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(2);
            dispatch_semaphore_signal(semaphore);
        });
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //    dispatch_release(group);
    //    dispatch_release(semaphore);
    //6.0之后不再需要手动释放
}

- (void)secondTest {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"等待前");
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"等待后执行");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"异步开始");
        sleep(2);
        NSLog(@"异步睡醒了");
        dispatch_semaphore_signal(semaphore);
        NSLog(@"异步信号量+1");
    });
    
    NSLog(@"主线程一路狂奔");
    //    NSLog(@"等待前");
    //    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//wait 会阻塞线程，不可放在主线程
    //    NSLog(@"等待后执行");
}

- (void)thirdTest {
    dispatch_queue_t queue = dispatch_queue_create("11111", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        dispatch_sync(queue, ^{
            for (NSInteger i = 0; i < 3; i ++) {
                sleep(1);
                NSLog(@"任务1 - 同步执行 - %ld",(long)i);
            }
        });
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_sync(queue, ^{
            for (NSInteger i = 0; i < 3; i ++) {
                sleep(1);
                NSLog(@"任务2 - 同步执行 - %ld",(long)i);
            }
        });
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"上面两个任务都执行完了");
    });
    
    //dispatch_group_async 和 dispatch_group_notify 组合在执行同步任务时正常
}

- (void)fourthTest {
    //    DISPATCH_QUEUE_SERIAL_INACTIVE
    dispatch_queue_t queue = dispatch_queue_create("11111", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        dispatch_async(queue, ^{
            for (NSInteger i = 0; i < 3; i ++) {
                sleep(1);
                NSLog(@"任务1 - 异步执行 - %ld",(long)i);
            }
        });
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_async(queue, ^{
            for (NSInteger i = 0; i < 3; i ++) {
                sleep(1);
                NSLog(@"任务2 - 异步执行 - %ld",(long)i);
            }
        });
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"上面两个任务都执行完了");
    });
    
    //dispatch_group_async 和 dispatch_group_notify 组合在执行异步任务时出问题了
}

- (void)fifthTest {
    dispatch_queue_t queue = dispatch_queue_create("123456", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"step - 1");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"step - 2");
    });
    dispatch_async(queue, ^{
        NSLog(@"step - 3");
    });
    
    //    dispatch_barrier_sync(queue, ^{
    //        sleep(2);
    //        NSLog(@"插入的任务");
    //    });
    
    dispatch_barrier_async(queue, ^{
        sleep(2);
        NSLog(@"插入的任务");
    });
    
    NSLog(@"AAA");
    dispatch_async(queue, ^{
        NSLog(@"step - 4");
    });
    
    NSLog(@"BBB");
    dispatch_async(queue, ^{
        NSLog(@"step - 5");
    });
    dispatch_async(queue, ^{
        NSLog(@"step - 6");
    });
    
    /* dispatch_barrier_sync 和 dispatch_barrier_async 同步等待和异步等待的区别
     
     dispatch_barrier_sync 先执行自己的任务，然再将下面的任务添加到队列，再继续执行队列中的任务
     dispatch_barrier_async 现将所有的任务都添加到队列，再按照顺序执行队列中的任务
     
     从 AAA 和 BBB的执行时间得出区别
     
     */
}

- (void)sixTest {
    //    DISPATCH_QUEUE_PRIORITY_DEFAULT
    
    //iOS 8 后使用 QOS创建队列
    
    dispatch_queue_attr_t att = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_DEFAULT, -1);
    
    dispatch_queue_t queue = dispatch_queue_create("123123", att);
    dispatch_async(queue, ^{
        NSLog(@"123123");
    });
}

- (void)sevenTest {
    dispatch_queue_t targetQueue = dispatch_queue_create("targetQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    
    //现在 queue1的优先级和targeQueue优先级一样，  queue2也是
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    
    dispatch_async(queue1, ^{
        NSLog(@"11111111----%@",[NSThread currentThread]);
        sleep(3);
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"22222222----%@",[NSThread currentThread]);
        sleep(2);
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"33333333----%@",[NSThread currentThread]);
        sleep(1);
    });
    
    //设置两个队列到一个队列优先级上， 都在同一个线程执行 ， 所有通过睡眠时间 看出三个是按顺序执行的
}

- (void)eightTest {
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_CONCURRENT);
    
    //危险，可能导致线程爆炸以及死锁
    for (NSInteger i = 0; i < 999; i ++) {
        dispatch_async(queue, ^{
            
        });
    }
    dispatch_barrier_sync(queue, ^{
        
    });
    
    //较优选择 ， GCD会管理并发
    dispatch_apply(999, queue, ^(size_t i) {
        
    });
}

- (void)ninthTest {
    dispatch_queue_t queue = dispatch_queue_create("customQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t block1 = dispatch_block_create(0, ^{
        NSLog(@"第一个函数回调");
        sleep(2);
    });
    
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        NSLog(@"第二个函数回调");
    });
    
    dispatch_async(queue, block1);
    
    NSLog(@"嘿嘿嘿");
    dispatch_block_notify(block1, queue, block2);
    //第一个block执行完后，得到通知，然后第二个block执行， 不会阻塞线程
}

- (void)tenthTest {
    
}

bool CFunction(void) {
    return YES;
}

@end
