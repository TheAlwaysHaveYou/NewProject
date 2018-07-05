//
//  CoreAnimtionController.m
//  NewProject
//
//  Created by 范魁东 on 2018/6/28.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "CoreAnimtionController.h"
#import "DrawRectView.h"
#import "LEEAlert.h"

@interface CoreAnimtionController ()

@end

@implementation CoreAnimtionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self oneTest];
    
    [self twoTest];
}

- (void)oneTest {
    DrawRectView *view = [[DrawRectView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];
    [self.view addSubview:view];
}

- (void)twoTest {
    [LEEAlert alert].config.
    LeeAddCustomView(^(LEECustomView *custom) {
        
    }).
    LeeCustomView([UIView new]).
    LeeShow();
}

@end
