//
//  ToolListItem.h
//  NewProject
//
//  Created by 范魁东 on 2022/2/9.
//  Copyright © 2022 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolListItemViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolListItem : UICollectionViewCell

- (void)updateUI:(ToolListItemViewModel *)vm;

@end

NS_ASSUME_NONNULL_END
