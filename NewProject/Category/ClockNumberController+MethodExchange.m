//
//  ClockNumberController+MethodExchange.m
//  NewProject
//
//  Created by 范魁东 on 2021/9/5.
//  Copyright © 2021 fan. All rights reserved.
//

#import "ClockNumberController+MethodExchange.h"
#import <objc/runtime.h>


@implementation ClockNumberController (MethodExchange)

/*
 如果CategoryA先exchange原方法，让后CategoryB再exchange原方法，则执行结果  B->A->原方法
 
 
 */

+ (void)load {
    NSLog(@"MethodExchange --- load");
    Method origin  = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method other = class_getInstanceMethod(self, @selector(kd_viewDidLoad));
    method_exchangeImplementations(origin, other);
}

- (void)kd_viewDidLoad {
    NSLog(@"kd_viewDidLoad--1111");
    [self kd_viewDidLoad];
    NSLog(@"kd_viewDidLoad--2222");
}
//通过category实现方法HOOK
//- (void)viewDidLoad {
//    NSLog(@"category方法---");
//    int count ;
//    Method *methods = class_copyMethodList([self class], &count);
//    NSInteger index = 0;
//    for (NSInteger i = count-1; i>=0; i--) {
//        SEL name = method_getName(methods[i]);
//        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
//        NSLog(@"当前列遍历方法名---%@--",strName);
//        if ([strName isEqualToString:[NSString stringWithCString:_cmd encoding:NSUTF8StringEncoding]]) {
//            index = i;
//            NSLog(@"找到了了");
//            break;
//        }
//    }
//
//    SEL sel = method_getName(methods[index]);
//    IMP imp = method_getImplementation(methods[index]);
//
//    //找到的都是方法列表中第一个方法
////    IMP twoImp = [[self class] instanceMethodForSelector:sel];
////    IMP twoImp = [self methodForSelector:sel];
//    ((void (*)(id , SEL))imp)(self,sel);
//}

@end

@implementation ClockNumberController (MethodExchangeTwo)

+ (void)load {
    NSLog(@"MethodExchangeTwo --- load");
    Method origin = class_getInstanceMethod(self, @selector(kd_viewDidLoad));
    Method other = class_getInstanceMethod(self, @selector(two_kd_viewDidLoad));
    method_exchangeImplementations(origin, other);
}

- (void)two_kd_viewDidLoad {
    NSLog(@"two_kd_viewDidLoad--1111");
    [self two_kd_viewDidLoad];
    NSLog(@"two_kd_viewDidLoad--2222");
}

@end
