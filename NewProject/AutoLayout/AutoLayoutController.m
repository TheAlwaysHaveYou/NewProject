//
//  AutoLayoutController.m
//  NewProject
//
//  Created by 范魁东 on 2018/6/27.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "AutoLayoutController.h"
#import "FKDLabel.h"

@interface AutoLayoutController ()

@end

@implementation AutoLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self oneTest];
    
}

- (void)oneTest {
    FKDLabel *label = [FKDLabel new];
    label.backgroundColor = [UIColor cyanColor];
    label.text = @"qqqqqqqqqqaaaabbbbbnnnn";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
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


@end
