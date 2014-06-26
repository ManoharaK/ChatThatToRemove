//
//  BlurEffect.h
//  CustomPopoverView
//
//  Created by Varghese Simon on 6/6/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

@interface UIView (SnapshotImage)

-(UIImage *)convertViewToImage;

@end


@interface BlurEffect : NSObject

+ (GPUImageView *)blurredImageOfView:(UIView *)superView onBaseView:(UIView *)baseView withTintColor:(UIColor *)tintColor;

@end
