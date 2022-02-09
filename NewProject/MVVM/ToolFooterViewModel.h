//
//  ToolFooterViewModel.h
//  NewProject
//
//  Created by 范魁东 on 2022/2/9.
//  Copyright © 2022 fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolListViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolFooterViewModel : NSObject

@property (nonatomic , weak , readonly) ToolListViewModel *parentVM;

- (instancetype)initWithModel:(ToolListViewModel *)vm NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

- (CGFloat)height;
+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
