//
//  SpecialTimePickerView.m
//  NewProject
//
//  Created by 范魁东 on 2018/8/27.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "SpecialTimePickerView.h"

@interface SpecialTimePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic , strong) NSCalendar *calendar;

@property (nonatomic , strong) NSArray <NSArray <NSString *> *> *sourceArr;

@property (nonatomic , strong) NSArray <NSDate *> *dateArr;

@property (nonatomic , strong) UIView *contentView;

@property (nonatomic , strong) UIPickerView *pickerView;

@property (nonatomic , copy) void(^confirmBlock)(NSDate *);

@end

@implementation SpecialTimePickerView

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
        
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 260)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 40.f)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        [self.contentView addSubview:titleLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.f, 40.f, self.frame.size.width, 0.5f)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:line];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(10.f, 0.f, 42.f, 40.f);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cancelBtn];
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake(self.frame.size.width - 42.f - 10.f, 0.f, 42.f, 40.f);
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:confirmBtn];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, 220)];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self.contentView addSubview:self.pickerView];
        
        self.minDate = [NSDate date];
        self.maxDate = [[NSDate date] dateByAddingMonths:1];
    }
    return self;
}

//- (void)setMinDate:(NSDate *)minDate {
//    _minDate = minDate;
//    [self reloadDataSource];
//}

- (void)setMaxDate:(NSDate *)maxDate {
    _maxDate = [self filterTime:maxDate];
    [self reloadDataSource];
}

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    if (!currentDate) {
        return;
    }
    
    NSComparisonResult result = [currentDate compare:self.minDate];
    if (result < 0) {
        [self scrollToBestTimeWith:self.minDate];
    }else {
        [self scrollToBestTimeWith:currentDate];
    }
}

- (void)scrollToBestTimeWith:(NSDate *)originDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd";
    NSString *dayStr = [formatter stringFromDate:originDate];
    [self.dateArr enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *tempStr = [formatter stringFromDate:obj];
        if ([dayStr isEqualToString:tempStr]) {
            [self.pickerView selectRow:idx inComponent:0 animated:YES];
            *stop = YES;
        }
    }];
    
    formatter.dateFormat = @"HH";
    NSString *hourStr = [formatter stringFromDate:originDate];
    [self.sourceArr[1] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([hourStr isEqualToString:obj]) {
            [self.pickerView selectRow:idx inComponent:1 animated:YES];
            *stop = YES;
        }
    }];
    formatter.dateFormat = @"mm";
    NSString *minuteStr = [formatter stringFromDate:originDate];
    [self.sourceArr[2] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([minuteStr isEqualToString:obj]) {
            [self.pickerView selectRow:idx inComponent:2 animated:YES];
            *stop = YES;
        }
    }];
}

- (void)reloadDataSource {
    self.minDate = [self filterTime:self.minDate];
    
    self.sourceArr = @[[self getDays],[self getHour],[self getMinute]];
    [self.pickerView reloadAllComponents];
    
    //有最优时间显示最优，没有显示最小时间
    if (self.currentDate) {
        NSComparisonResult result = [self.currentDate compare:self.minDate];
        if (result < 0) {
            [self scrollToBestTimeWith:self.minDate];
        }else {
            [self scrollToBestTimeWith:self.currentDate];
        }
    }else {
        [self scrollToBestTimeWith:self.minDate];
    }
}

//过滤时间为整十分钟
- (NSDate *)filterTime:(NSDate *)date {
    NSString *str = [date stringWithFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *otherDate = [NSDate dateWithString:str format:@"yyyy-MM-dd HH:mm"];
    
    NSInteger remainder = otherDate.minute%10;//余数
    if (remainder > 0) {
        otherDate = [NSDate dateWithTimeInterval:(10-remainder)*60 sinceDate:otherDate];
    }
    return otherDate;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.sourceArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *tempArr = self.sourceArr[component];
    return tempArr.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return kScreenWidth/2;
    }else {
        return kScreenWidth/4;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *tempArr = self.sourceArr[component];
    NSString *str = tempArr[row];
    if (component == 1) {
        return [str stringByAppendingString:@"点"];
    }else if (component == 2) {
        return [str stringByAppendingString:@"分"];
    }
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSDate *date = [self changePickerViewTimeStringToDate];
    //对比最小最大时间
    NSComparisonResult minResult = [date compare:self.minDate];
    if (minResult < 0) {
        [self scrollToBestTimeWith:self.minDate];
        return;
    }
    
    NSComparisonResult maxResult = [date compare:self.maxDate];
    if (maxResult > 0) {
        [self scrollToBestTimeWith:self.maxDate];
        return;
    }
}

#pragma mark - Custon Action

- (void)cancelBtnAction:(UIButton *)sender {
    [self dismiss];
}

- (void)confirmBtnAction:(UIButton *)sender {
    if (self.confirmBlock) {
        NSDate *date = [self changePickerViewTimeStringToDate];
        self.confirmBlock(date);
    }
    
    [self dismiss];
}

- (NSDate *)changePickerViewTimeStringToDate {
    NSString *timeStr = @"";
    for (NSInteger i = 0; i < self.sourceArr.count; i ++) {
        NSInteger tempRow = [self.pickerView selectedRowInComponent:i];
        NSArray *tempArr = self.sourceArr[i];
        NSString *tempStr = tempArr[tempRow];
        
        if (i == 0) {
            NSDate *tempDate = self.dateArr[tempRow];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd";
            NSString *yearStr = [formatter stringFromDate:tempDate];
            timeStr = yearStr;
        }else if (i == 1) {
            timeStr = [timeStr stringByAppendingFormat:@" %@",tempStr];
        }else if (i == 2) {
            timeStr = [timeStr stringByAppendingFormat:@":%@:00",tempStr];
        }
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:timeStr];
    return date;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self.contentView.layer addAnimation:animation forKey:@"DatePickerSheet"];
    
    CGRect rect = self.contentView.frame;
    rect.origin.y = self.frame.size.height-rect.size.height;
    self.contentView.frame = rect;
}

- (void)dismiss {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self.contentView setAlpha:0.f];
    [self.contentView.layer addAnimation:animation forKey:@"DatePickerSheet"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
}

- (void)setConfirmWithBlock:(void(^)(NSDate *date))block {
    self.confirmBlock = block;
}

#pragma mark - SourceManager

- (NSArray<NSString *> *)getDays {
    NSDateComponents *components = [self.calendar components:(NSCalendarUnitDay)
                                                    fromDate:self.minDate
                                                      toDate:self.maxDate?:self.minDate
                                                     options:0];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    NSMutableArray *dateArr = [NSMutableArray array];
    for (NSInteger i = 0; i <= [components day]+1; i ++) {
        NSDate *tempDate = [self.minDate dateByAddingDays:i];
        [dateArr addObject:tempDate];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM-dd EEEE";
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [tempArr addObject:[formatter stringFromDate:tempDate]];
    }
    self.dateArr = [NSArray arrayWithArray:dateArr];
    return tempArr;
}

- (NSArray<NSString *> *)getHour {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 24; i ++) {
        if (i < 10) {
            [tempArr addObject:[NSString stringWithFormat:@"0%ld",(long)i]];
        }else {
            [tempArr addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }
    return tempArr;
}
- (NSArray<NSString *> *)getMinute {
    return @[@"00",@"10",@"20",@"30",@"40",@"50"];
}

@end
