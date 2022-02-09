//
//  SecondController.m
//  NewProject
//
//  Created by fan on 17/5/22.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "SecondController.h"
#import "FKDTimerVC.h"

#define WIDTH 10
#define HEIGHT 10
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500


@interface MyPerson : NSObject

@property (nonatomic , strong) NSString*name;
@end

@implementation MyPerson

- (void)dealloc {
    NSLog(@"person释放了");
}

@end
@interface SecondController ()

@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , copy) void(^myblock)(void);
@property (nonatomic , strong) NSString*name;

@property (nonatomic , strong) NSTimer *timer;

@end

@implementation SecondController
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return YES;
//}
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return self;
//}
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    return  NULL;
//}
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//
//}
//- (void)doesNotRecognizeSelector:(SEL)aSelector {
//    
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    MyPerson *person = [[MyPerson alloc] init];
//    void(^block)(void) = ^{
//        person.name = @"11";
//        NSLog(@"block执行");
//
//    };
//    NSLog(@"1111");
//    block();
//    NSLog(@"2222");
    
//    __weak typeof(self)weakSelf = self;
//    self.myblock = ^{
////        weakSelf->_name = @"";
//        self->_name = @"";
//        self.name = @"";
//    };
    [self setValue:@"1111" forKey:@"haha"];
    id key = [self valueForKey:@"haha"];
    
}
- (NSString *)name {
    return @"";
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
- (id)valueForUndefinedKey:(NSString *)key {
    return  @"11";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *sql = @"create table bulktest1 (id integer primary key autoincrement, x text);"
    "create table bulktest2 (id integer primary key autoincrement, y text);"
    "create table bulktest3 (id integer primary key autoincrement, z text);"
    "insert into bulktest1 (x) values ('XXX');"
    "insert into bulktest2 (y) values ('YYY');"
    "insert into bulktest3 (z) values ('ZZZ');";
    NSLog(@"spl 语句 ------    %@",sql);
    
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(timeFire) userInfo:nil repeats:YES];
//    [self.timer fire];
    
//    [self _3Dmatrix];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(textOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)timeFire {
    NSLog(@"gogogog");
}

- (void)textOne {
    FKDTimerVC *vc = [[FKDTimerVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//3D图形矩阵
- (void)_3Dmatrix {
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING, (HEIGHT - 1)*SPACING);
    
    //set up perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;
    
    //create layers
    for (int z = DEPTH - 1; z >= 0; z--) {
        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) {
                //create layer
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING;
                //set background color
                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
                //attach to scroll view
                [self.scrollView.layer addSublayer:layer];
            }
        }
    }
    NSLog(@"displayed: %i", DEPTH*HEIGHT*WIDTH);
}

@end
