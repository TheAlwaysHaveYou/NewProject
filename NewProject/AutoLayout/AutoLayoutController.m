//
//  AutoLayoutController.m
//  NewProject
//
//  Created by 范魁东 on 2018/6/27.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "AutoLayoutController.h"
#import "FKDLabel.h"
#import "AutoOneView.h"

@interface AutoLayoutController ()

@end

@implementation AutoLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self oneTest];
    [self twoTest];
}

- (void)oneTest {
    FKDLabel *label = [FKDLabel new];
    label.backgroundColor = [UIColor cyanColor];
    label.text = @"qqqqqqqqqqaaaabbbbbnnnn";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;//不允许AutoresizingMask 转换为AutoLayout
    [self.view addSubview:label];
    
    //没有这事宽度， 因为会根据label显示的内容自适应宽度， 如果text没有，则没有宽度
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
                                [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-20],
                                ]];
    //当旋转屏幕的时候 label的做小高度为 150
    NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.3 constant:0];
    con.priority = UILayoutPriorityDefaultHigh;
    [self.view addConstraint:con];
    
    [label addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:150]];
    
    
    
    NSLog(@"label内在尺寸 ---%@",NSStringFromCGSize(label.intrinsicContentSize));
    
    //    label.frame = CGRectMake(0, 50, label.intrinsicContentSize.width, 50);
    
}

- (void)twoTest {
    /*
     setContentHuggingPriority
     抗拉伸属性，  级别越高， 越不容易被拉伸
     setContentCompressionResistancePriority
     抗压缩属性，  级别越高， 越不容易被压缩
     
     UILayoutConstraintAxisHorizontal  横向
     UILayoutConstraintAxisVertical    纵向
     */
    
    AutoOneView *view1 = [[AutoOneView alloc] init];
    view1.backgroundColor = [UIColor yellowColor];
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view1];
    
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeLeft constant:20];
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeTop constant:20];
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeRight constant:-20];
    
    AutoOneView *view2 = [[AutoOneView alloc] init];
    view2.backgroundColor = [UIColor cyanColor];
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    [view2 setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:view2];
    
    [self setEdge:self.view view:view2 attr:NSLayoutAttributeRight constant:-20];
    [self setEdge:self.view view:view2 attr:NSLayoutAttributeBottom constant:-20];
    [self setEdge:self.view view:view2 attr:NSLayoutAttributeLeft constant:20];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeBottom multiplier:1 constant:20]];
}

- (void)setEdge:(UIView *)superView view:(UIView *)view attr:(NSLayoutAttribute)attr constant:(CGFloat)constant {
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:attr relatedBy:NSLayoutRelationEqual toItem:superView attribute:attr multiplier:1 constant:constant]];
}

@end
