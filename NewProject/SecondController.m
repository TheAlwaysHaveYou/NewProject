//
//  SecondController.m
//  NewProject
//
//  Created by fan on 17/5/22.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "SecondController.h"

#define WIDTH 10
#define HEIGHT 10
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500



@interface SecondController ()

@property (nonatomic , strong) UIScrollView *scrollView;

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self _3Dmatrix];
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
