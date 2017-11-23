//
//  MyLottoCycleView.h
//  NewProject
//
//  Created by fan on 2017/11/5.
//  Copyright © 2017年 fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLottoCycleView : UIView

- (instancetype)initWithFrame:(CGRect)frame lottoArr:(NSArray *)lottoArr;

@property (nonatomic , strong) NSArray *lottoArr;

@end

@interface MyLottoCycleModelView : UIView


@end

