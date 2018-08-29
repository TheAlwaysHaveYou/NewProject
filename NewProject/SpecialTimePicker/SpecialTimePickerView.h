//
//  SpecialTimePickerView.h
//  NewProject
//
//  Created by 范魁东 on 2018/8/27.
//  Copyright © 2018年 fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialTimePickerView : UIView
/*时间上下限同时存在*/
@property (nonatomic , strong) NSDate *minDate;
@property (nonatomic , strong) NSDate *maxDate;
@property (nonatomic , strong) NSDate *currentDate;

- (instancetype)initWithTitle:(NSString *)title;

- (void)setConfirmWithBlock:(void(^)(NSDate *date))block;

- (void)show;

@end
