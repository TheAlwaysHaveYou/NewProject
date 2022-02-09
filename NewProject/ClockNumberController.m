//
//  ClockNumberController.m
//  NewProject
//
//  Created by fan on 17/5/16.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "ClockNumberController.h"
#import "GCDAsyncSocket.h"

@interface ClockNumberController ()<GCDAsyncSocketDelegate>

@property (nonatomic , strong) UITextField *textField;
@property (nonatomic , strong) GCDAsyncSocket *clientSocket;
@property (nonatomic , strong) NSTimer *connectTimer;

@end

@implementation ClockNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ClockNumberController---viewDidLoad---原方法");
    
//    [self GCDTest];
    
    [self socketService];
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

- (void)socketService {
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
    self.textField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textField];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, 40, 40)];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    [self.clientSocket connectToHost:@"192.168.0.103" onPort:12345 viaInterface:nil withTimeout:-1 error:&error];
    if (error) {
        NSLog(@"连接报错--%@",error.localizedDescription);
    }
    
    
}
- (void)sendMessage:(UIButton *)sender {
    [self.view resignFirstResponder];
    NSString *text = self.textField.text;
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}

- (void)addCostomeTime {
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        //发送心跳连接
        float version = [[UIDevice currentDevice] systemVersion].floatValue;
        NSString *logConnect = [NSString stringWithFormat:@"999%f",version];
        NSData *data = [logConnect dataUsingEncoding:NSUTF8StringEncoding];
        [self.clientSocket writeData:data withTimeout:-1 tag:0];
        
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.connectTimer forMode:NSRunLoopCommonModes];
}
#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"连接到了host--%@--port--%d",host,port);
    [self addCostomeTime];
}
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSLog(@"收到了服务端的回信--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"客户端断开连接");
    self.clientSocket.delegate = nil;
    self.clientSocket = nil;
    [self.connectTimer invalidate];
}
@end
