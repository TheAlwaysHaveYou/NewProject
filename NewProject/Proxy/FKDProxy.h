//
//  FKDProxy.h
//  NewProject
//
//  Created by 范魁东 on 2018/8/21.
//  Copyright © 2018年 fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKDMethodA.h"
#import "FKDMethodB.h"


@interface FKDProxy : NSProxy <FKDMethodAProtocol , FKDMethodBProcotol>

+ (instancetype)dealerProxy;

@end
