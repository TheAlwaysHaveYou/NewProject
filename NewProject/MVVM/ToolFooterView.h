//
//  ToolFooterView.h
//  NewProject
//
//  Created by 范魁东 on 2022/2/9.
//  Copyright © 2022 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolFooterViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolFooterView : UICollectionReusableView

@property (nonatomic , copy) dispatch_block_t click;

- (void)updateUI:(ToolFooterViewModel *)vm;

@end

NS_ASSUME_NONNULL_END
