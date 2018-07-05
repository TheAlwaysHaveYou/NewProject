//
//  DrawRectView.m
//  NewProject
//
//  Created by 范魁东 on 2018/6/28.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "DrawRectView.h"

@implementation DrawRectView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    NSLog(@"----%@",NSStringFromCGRect(self.frame));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
//    CGContextMoveToPoint(context, 0, self.frame.size.height/2);
//    CGContextAddArcToPoint(context, self.frame.size.width/2, -self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2, self.frame.size.width);
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height*2, self.frame.size.height*1.7, 0, M_PI, 1);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);
    
    CGContextFillPath(context);
}

@end
