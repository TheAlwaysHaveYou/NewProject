//
//  CustomImageController.m
//  NewProject
//
//  Created by fan on 2017/11/23.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "CustomImageController.h"

@interface CustomImageController ()

@end

@implementation CustomImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self creatSHuiyin:photoImage];
}

- (void)creatSHuiyin:(UIImage *)image {
    UIImage *water = [self addWaterMarkTextWithOriginalImage:image waterMarkText:@"@这是加的水印"];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imgV.backgroundColor = [UIColor blackColor];
    imgV.image = water;
    imgV.contentMode = UIViewContentModeScaleAspectFit;
//    [BBYSharedAppWindow addSubview:imgV];
}

- (UIImage *)addWaterMarkTextWithOriginalImage:(UIImage *)originalImage waterMarkText:(NSString *)waterMarkText{
    CGFloat width = originalImage.size.width;
    CGFloat height = originalImage.size.height;
    
    UIGraphicsBeginImageContext(originalImage.size);
    [originalImage drawInRect:CGRectMake(0, 0, width, height)];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:25.f],NSForegroundColorAttributeName : [UIColor whiteColor]};
    CGSize size = [waterMarkText boundingRectWithSize:CGSizeMake(MAXFLOAT, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    [waterMarkText drawInRect:CGRectMake(width-size.width-20, height-size.height-5, size.width, size.height) withAttributes:attributes];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"当前线程 -----  %@",[NSThread currentThread]);
    
    return newImage;
}


@end
