//
//  FKD.m
//  NewProject
//
//  Created by 范魁东 on 2018/9/20.
//  Copyright © 2018年 fan. All rights reserved.
//

#import "FKD.h"

@implementation FKD

- (void)asdfasdfadsfafa:(NSInteger)originNumber {
    NSString *str = [@(originNumber) stringValue];
    
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:str.length];
    for (int i = str.length - 1; i >=0 ; i --) {
        unichar ch = [str characterAtIndex:i];
        [newString appendFormat:@"%c", ch];
    }
    
    NSString *str = [NSString stringWithFormat:@"%d",originNumber];
    
}



@end
