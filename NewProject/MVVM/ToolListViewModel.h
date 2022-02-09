//
//  ToolListViewModel.h
//  NewProject
//
//  Created by 范魁东 on 2022/2/9.
//  Copyright © 2022 fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolListItemViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ToolFooterViewModel;
@interface ToolListViewModel : NSObject

@property (nonatomic , assign , readonly) BOOL canFold;
@property (nonatomic , assign) NSInteger columnCount;

@property (nonatomic , strong , readonly) NSObject *model;
@property (nonatomic , strong) ToolFooterViewModel *footerVM;

- (NSInteger)itemCount;
- (BOOL)isValid;
- (CGFloat)height;
- (CGFloat)width;

+ (CGFloat)minimumLineSpacing;
+ (CGFloat)minimumInteritemSpacing;

- (ToolListItemViewModel *)itemAtIndexPath:(NSIndexPath *)indexPath;
- (instancetype)initWithModel:(NSObject *)model NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
