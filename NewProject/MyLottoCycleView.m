//
//  MyLottoCycleView.m
//  NewProject
//
//  Created by fan on 2017/11/5.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "MyLottoCycleView.h"

@interface MyLottoCycleView ()


@property (nonatomic,strong)NSMutableDictionary *cornerDic;

@end

@implementation MyLottoCycleView


static inline float radians(double degrees) {
    return degrees * M_PI / 180;
}

static inline void drawArc(CGContextRef ctx, CGPoint point, float radius,float angle_start, float angle_end, UIColor* color) {
    //设置填充颜色
    CGContextSetFillColor(ctx, CGColorGetComponents( [color CGColor]));
    //移动画笔
    CGContextMoveToPoint(ctx, point.x, point.y);
    //画扇形
    CGContextAddArc(ctx, point.x, point.y, radius,  angle_start, angle_end, 0);
    //填充
    CGContextFillPath(ctx);
    //画中间的白色分割线
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    //设置线条宽度
    CGContextSetLineWidth(ctx, 2);
    CGContextMoveToPoint(ctx, point.x, point.y);
    //算出线另一端的坐标
    CGPoint point1 = CGPointMake(point.x + radius*cos(angle_start), point.y + radius*sin(angle_start));
    //画线
    CGContextAddLineToPoint(ctx, point1.x, point1.y);
    CGContextStrokePath(ctx);
}


- (instancetype)initWithFrame:(CGRect)frame lottoArr:(NSArray *)lottoArr {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = self.frame.size.width/2;
        self.layer.borderWidth = 9;
        self.layer.borderColor = [UIColor colorWithRed:243/255.0 green:88/255.0 blue:31/255.0 alpha:1].CGColor;
        
        
        self.lottoArr = @[@"电饭锅",@"充电器",@"手机",@"煤气罐",@"笔记本",@"饮料",@"牛奶",@"面包"];

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    srand((unsigned)time(0));
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.width/2);
    
    float angle_start = 0;
    float angle_end = 0;
    int i = 0;
    
    
    UIColor *yelloColor = [UIColor colorWithRed:249/255.0 green:226/255.0 blue:55/255.0 alpha:1];
    UIColor *redColor = [UIColor colorWithRed:247/255.0 green:148/255.0 blue:53/255.0 alpha:1];
    
    //遍历字典，画饼
    for (NSString *key in self.lottoArr) {
        angle_start = angle_end;
        angle_end = angle_start+ 45.0/180.0*M_PI;
        
        UIColor *color = nil;
        if (i%2 == 0) {
            color = yelloColor;
        }
        else
        {
            color = redColor;
        }
        //画扇形
        drawArc(ctx, center, self.frame.size.width/2-self.layer.borderWidth, angle_start, angle_end, color);
        i++;

        MyLottoCycleModelView *modelView = [self modelViewWith:key rotate:angle_start + (angle_end-angle_start)/2];
        [self addSubview:modelView];
    }
}

- (MyLottoCycleModelView *)modelViewWith:(NSString*)text rotate:(CGFloat)angel {
    
    MyLottoCycleModelView *view = [[MyLottoCycleModelView alloc] initWithFrame:CGRectMake(self.frame.size.width*3/8, 30, self.frame.size.width/4, self.frame.size.width/2-30)];
    
    float centerX = view.bounds.size.width/2;
    float centerY = view.bounds.size.height/2;
    float x = view.bounds.size.width/2;
    float y = view.bounds.size.height;
    
    CGAffineTransform trans = GetCGAffineTransformRotateAroundPoint(centerX,centerY ,x,y,angel);
    view.transform = CGAffineTransformIdentity;
    view.transform = trans;
    
    return view;
}

CGAffineTransform  GetCGAffineTransformRotateAroundPoint(float centerX, float centerY ,float x ,float y ,float angle)
{
    x = x - centerX; //计算(x,y)从(0,0)为原点的坐标系变换到(CenterX ，CenterY)为原点的坐标系下的坐标
    y = y - centerY; //(0，0)坐标系的右横轴、下竖轴是正轴,(CenterX,CenterY)坐标系的正轴也一样
    
    CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
    trans = CGAffineTransformRotate(trans,angle);
    trans = CGAffineTransformTranslate(trans,-x, -y);
    return trans;
}

@end

#pragma mark - MyLottoCycleModelView

@interface MyLottoCycleModelView ()

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UIImageView *imgV;

@end

@implementation MyLottoCycleModelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    self.nameLabel.font = [UIFont systemFontOfSize:16.f];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.backgroundColor = [UIColor greenColor];
    [self addSubview:self.nameLabel];
    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 30, 30)];
    self.imgV.backgroundColor = [UIColor redColor];
    [self addSubview:self.imgV];
}


@end
