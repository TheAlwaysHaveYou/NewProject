//
//  ToolListItemViewModel.h
//  NewProject
//
//  Created by 范魁东 on 2022/2/9.
//  Copyright © 2022 fan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolListItemViewModel : NSObject

@property (nonatomic , copy) NSString *mainTitle;
@property (nonatomic , copy) NSString *linkUrl;
@property (nonatomic , copy) NSString *imageUrl;

- (CGFloat)height;
+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
