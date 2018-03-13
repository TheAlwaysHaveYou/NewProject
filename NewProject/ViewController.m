//
//  ViewController.m
//  NewProject
//
//  Created by fan on 17/5/9.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/EAGL.h>
#import "FKDLabel.h"
#import "MyLottoCycleView.h"
#import "CustomView.h"

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

typedef struct {
    NSInteger age;
    char *name;
}MyName;

@interface ViewController ()

@property (nonatomic , strong) UIView *containerView;

@property (nonatomic , strong) NSMutableArray *subViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyName nn = {1,""};
    nn.age = 123;
    
//    FKDLabel *label = [[FKDLabel alloc] init];
    
//    [self separaterImageForViewLayer];
    
//    [self changeAlphaWithMoreView];
    
//    [self _3DView];
    
//    [self CATextLayerForText];
    
    
    
    
    [self codeAnimation];
    
}

- (void)codeAnimation {
    
    CustomView *view = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    
    [self.view addSubview:view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view addUntitled1AnimationCompletionBlock:^(BOOL finished) {
            NSLog(@"动画做完了");
        }];
    });
    
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
//    layer.contentsScale = [UIScreen mainScreen].scale;
//    layer.doubleSided = NO;//图层双面绘制, NO,背面不绘制
    
    //Y轴旋转45度
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    layer.transform = transform;
}
//解决组透明
- (void)changeAlphaWithMoreView {
    UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 300, 300)];
    btn.backgroundColor = [UIColor blackColor];
    btn.alpha = 0.5;
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"解决组透明";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [btn addSubview:label];
    
    btn.layer.shouldRasterize = YES;
    btn.layer.rasterizationScale = [UIScreen mainScreen].scale;//匹配屏幕防止retain屏幕像素化问题
}
//3D六面体
- (void)_3DView {
    self.subViews = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.containerView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.containerView];
    
    for (NSInteger i = 1; i < 7; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        label.text = [NSString stringWithFormat:@"%ld",(long)i];
        [self.subViews addObject:label];
    }

    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 =  -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    UILabel *face = self.subViews[index];
    [self.containerView addSubview:face];
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    face.layer.transform = transform;
    //apply lighting  添加光影效果 没出来,尴尬了
    [self applyLightingToFace:face.layer];
}
- (void)applyLightingToFace:(CALayer *)face {
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}
//CATextLayer绘制文字
- (void)CATextLayerForText {
    self.containerView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.containerView];
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.containerView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.containerView.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.wrapped = YES;
    
    
    UIFont *font = [UIFont systemFontOfSize:20];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    textLayer.string = @"“Lorem ipsum dolor sit amet, consectetur adipiscing \n elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \n leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \n fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \n lobortis”";
    
}



@end
