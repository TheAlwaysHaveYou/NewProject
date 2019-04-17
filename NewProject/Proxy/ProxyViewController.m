//
//  ProxyViewController.m
//  NewProject
//
//  Created by 范魁东 on 2018/8/21.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "ProxyViewController.h"
#import "FKDProxy.h"
#import "SpecialTimePickerView.h"
#import <libkern/OSAtomic.h>
#import <os/lock.h>
#import "TempController.h"

@interface ProxyViewController ()

@property (nonatomic , strong) NSDate *currentDate;

@property (nonatomic , assign) OSSpinLock lock;

@end

@implementation ProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSProxy  实现多继承  https://www.jianshu.com/p/8e700673202b
    FKDProxy *proxy = [FKDProxy dealerProxy];
    [proxy todoAMethodWithName:@"嘿嘿嘿"];
    [proxy todoBMethodWithName:@"哈哈哈"];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}



- (void)btnAction:(UIButton *)sender {
    TempController *vc = [[TempController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
    
    self.lock = OS_SPINLOCK_INIT;
    
    for (NSInteger i = 0; i < 5; i ++) {//五个窗口同时买票
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (NSInteger x = 0; x < 10; x++) {
                [self sellingTickets];
            }
        });
    }
    
    return;
    
    
    @weakify(self)
    SpecialTimePickerView *pickerView = [[SpecialTimePickerView alloc] initWithTitle:@"选择时间"];
    pickerView.currentDate = self.currentDate;
    [pickerView setConfirmWithBlock:^(NSDate *date) {
        
        @strongify(self)
        self.currentDate = date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        NSLog(@"选择的时间---%@----%@",date,[formatter stringFromDate:date]);
    }];
    
//    pickerView.maxDate = [[NSDate date] dateByAddingMonths:5];
    [pickerView show];
}

- (void)sellingTickets {
    OSSpinLockLock(&_lock);
    static NSInteger tempCount = 20;
//    @synchronized (self) {
    
        [NSThread sleepForTimeInterval:1];
        tempCount--;
        
        NSLog(@"剩余票数-----%ld--%@",(long)tempCount,[NSThread currentThread]);
//    }
    OSSpinLockUnlock(&_lock);
}

@end
