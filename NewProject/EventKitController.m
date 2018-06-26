//
//  EventKitController.m
//  NewProject
//
//  Created by 范魁东 on 2018/6/25.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "EventKitController.h"
#import <EventKit/EventKit.h>
#import "LEEAlert.h"

@interface EventKitController ()

@end

@implementation EventKitController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(showAlerView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)showAlerView:(UIButton *)sender {
    [LEEAlert alert].config.LeeAddAction(^(LEEAction *action) {
        action.title = @"2323";
        action.clickBlock = ^{
            NSLog(@"嘿嘿嘿");
        };
    }).LeeShow();
    
}

- (void)eventKitTest {
    EKEventStore *store = [[EKEventStore alloc] init];
    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent] == EKAuthorizationStatusAuthorized) {
        EKCalendar *calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:store];
        
        for (EKSource *source in store.sources) {
            NSLog(@"%@---",source.title);
            if (source.sourceType == EKSourceTypeLocal) {
                calendar = [store calendarWithIdentifier:source.sourceIdentifier];
                
                
                EKEvent *event = [EKEvent eventWithEventStore:store];
                event.title = @"自定义事件";
                event.startDate = [NSDate date];
                event.endDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
                [event setCalendar:[store defaultCalendarForNewEvents]];
                
                NSError *error;
                
                [store saveEvent:event span:EKSpanThisEvent error:&error];
                if (error) {
                    NSLog(@"存储时间报错 ----  %@",error);
                }else {
                    NSLog(@"时间标识符-----%@",event.eventIdentifier);//C599A773-6154-4FDA-B5B5-BCC7882B7A86:02C9E87C-53D9-4075-BFDF-62720A3C945C
                }
                
            }
            
            //            NSDate *endDate = [[NSDate date] dateByAddingTimeInterval:24*60*60];
            //            NSPredicate *predicate = [store predicateForEventsWithStartDate:[NSDate date] endDate:endDate calendars:@[calendar]];
            //
            //            [store eventsMatchingPredicate:predicate];
            
            
        }
        
    }else {
        NSLog(@"请求权限---");
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"获得权限");
            }else {
                NSLog(@"权限获取失败-----%@",error);
            }
        }];
    }
}

@end
