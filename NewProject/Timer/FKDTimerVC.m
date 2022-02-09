//
//  FKDTimerVC.m
//  NewProject
//
//  Created by 范魁东 on 2021/7/31.
//  Copyright © 2021 fan. All rights reserved.
//

#import "FKDTimerVC.h"



@interface FKDTimerModel : NSObject<NSCopying>

//@property (nonatomic , strong) NSString *name;

@end

@implementation FKDTimerModel

//- (id)copyWithZone:(nullable NSZone *)zone {
////    FKDTimerModel *model = [FKDTimerModel copyWithZone:zone];
//
//}
@end

@interface FKDTimerVC ()

@property (nonatomic , strong) dispatch_source_t timer;

@property (nonatomic , strong) UILabel *label;

@property (nonatomic , copy) FKDTimerModel *model;

@end

extern void _objc_autoreleasePoolPrint(void);

@implementation FKDTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    self.label.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.label];
    
    __block NSInteger i = 1;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, (1 * NSEC_PER_SEC)), (1 * NSEC_PER_SEC), 0);
    @weakify(self)
    dispatch_source_set_event_handler(self.timer, ^{
        @strongify(self)
        i = (i==1) ? 0 : 1;
        self.label.backgroundColor = i==1 ? [UIColor cyanColor]:[UIColor greenColor];
        NSLog(@"开始了--%@",[NSThread currentThread]);
        
    });
//    dispatch_resume(self.timer);
    NSLog(@"----%@---",[NSRunLoop currentRunLoop]);
    @autoreleasepool {
        UILabel *label = [[UILabel alloc] init];
        _objc_autoreleasePoolPrint();
    }
    
    [CALayer new];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    dispatch_resume(self.timer);
    FKDTimerModel *model = [[FKDTimerModel alloc] init];
//    model.name = @"HHHH";
    self.model = model;
}
- (void)dealloc {
    NSLog(@"%s release",_cmd);
}



@end
