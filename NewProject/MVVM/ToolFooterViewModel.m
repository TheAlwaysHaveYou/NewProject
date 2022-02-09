//
//  ToolFooterViewModel.m
//  NewProject
//
//  Created by 范魁东 on 2022/2/9.
//  Copyright © 2022 fan. All rights reserved.
//

#import "ToolFooterViewModel.h"

@interface ToolFooterViewModel ()

@property (nonatomic , weak) ToolListViewModel *parentVM;

@end

@implementation ToolFooterViewModel

- (instancetype)initWithModel:(ToolListViewModel *)vm {
    self = [super init];
    if (self) {
        _parentVM = vm;
    }
    return self;
}

- (CGFloat)height {
    if (self.parentVM.canFold) {
        return 45;
    }else {
        return 0;
    }
}

+ (NSString *)identifier {
    return @"ToolFooterIdentifier";
}

@end
