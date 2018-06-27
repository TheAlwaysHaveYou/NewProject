//
//  FKDLabel.m
//  NewProject
//
//  Created by fan on 17/5/12.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "FKDLabel.h"

@implementation FKDLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
//        self setContentHuggingPriority:<#(UILayoutPriority)#> forAxis:<#(UILayoutConstraintAxis)#>
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];//不加这句， label本身的绘制功能就没啦，例如：text不显示
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, 0, self.bounds.size.height/2);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height/2);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextMoveToPoint(context, 10, 100);
    CGContextAddCurveToPoint(context, 200, 50, 100, 400, 300, 400);
    CGContextStrokePath(context);
}

@end
