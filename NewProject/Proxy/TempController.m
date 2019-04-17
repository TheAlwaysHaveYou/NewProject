
//
//  TempController.m
//  NewProject
//
//  Created by 范魁东 on 2019/3/19.
//  Copyright © 2019年 fan. All rights reserved.
//

#import "TempController.h"

@interface TempController ()

@property (nonatomic , weak) NSTimer *timer;

@end

@implementation TempController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeNumber) userInfo:nil repeats:YES];;
    [[NSRunLoop alloc] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [[NSRunLoop alloc] run];
    CADisplayLink
}

- (void)changeNumber {
    static NSInteger count = 10;
    NSLog(@"定时器gogog----%d",count--);
}

- (void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSLog(@"界面释放了-----");
}

@end
