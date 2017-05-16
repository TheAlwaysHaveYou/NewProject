//
//  ViewController.m
//  NewProject
//
//  Created by fan on 17/5/9.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "ViewController.h"

#import "FKDLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    FKDLabel *label = [[FKDLabel alloc] init];
    
    [self separaterImageForViewLayer];
    
}

//layer层分割图片效果
- (void)separaterImageForViewLayer {
    UIImage *image = [UIImage imageNamed:@"beautiful.jpeg"];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(150, 0, 100, 100)];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 100, 100)];
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];
    
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:view1.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:view2.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:view3.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:view4.layer];
}
- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer {
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
}

@end
