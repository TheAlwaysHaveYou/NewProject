//
//  CustomImageController.h
//  NewProject
//
//  Created by fan on 2017/11/23.
//  Copyright © 2017年 fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageController : UIViewController


/**
 *  :smile: 文本转换成原生表情
 */
+ (NSString *)emojiStringFromString:(NSString *)text;

/**
 *  原生表情转换成 :smile: 文本
 */
+ (NSString *)plainStringFromEmojiString:(NSString *)emojiText;


@end
