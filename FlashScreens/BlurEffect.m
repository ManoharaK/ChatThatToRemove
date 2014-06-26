//
//  BlurEffect.m
//  CustomPopoverView
//
//  Created by Varghese Simon on 6/6/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "BlurEffect.h"

@implementation UIView (SnapshotImage)

- (UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }else
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation BlurEffect
{
    NSString *string;
}

+ (GPUImageView *)blurredImageOfView:(UIView *)superView onBaseView:(UIView *)baseView withTintColor:(UIColor *)tintColor;
{
    NSDate *date = [NSDate date];
    GPUImageView *blurView = [[GPUImageView alloc] initWithFrame:(CGRectMake(0, 0, baseView.frame.size.width, baseView.frame.size.height))];
    blurView.clipsToBounds = YES;
    blurView.fillMode = kGPUImageFillModeStretch;
    
    GPUImageiOSBlurFilter *blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = 2.0f;
    
    UIView *tintView = [[UIView alloc] initWithFrame:blurView.frame];
    tintView.alpha = .2;
    tintView.backgroundColor = tintColor;
    [blurView addSubview:tintView];
    
    
    [baseView addSubview:blurView];
    [baseView sendSubviewToBack:blurView];
    
    UIDevice *currentDevice = [UIDevice currentDevice];
    [currentDevice beginGeneratingDeviceOrientationNotifications];
    UIInterfaceOrientation currentOrientaiton = [UIApplication sharedApplication].statusBarOrientation;
    [currentDevice endGeneratingDeviceOrientationNotifications];
    
    blurView.layer.contentsScale = [UIScreen mainScreen].scale;
    blurView.layer.contentsRect = [BlurEffect contentRectForView:baseView onSuperView:superView withOrientation:currentOrientaiton];
    
    UIImage *snapshotOfSuperView = [superView convertViewToImage];
    
    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:snapshotOfSuperView];
    
    [picture addTarget:blurFilter];
    [blurFilter addTarget:blurView];
    
    [picture processImageWithCompletionHandler:^{
        [blurFilter removeAllTargets];
        NSTimeInterval intervel = [[NSDate date] timeIntervalSinceDate:date];
        NSLog(@"Intervel = %f", intervel);
    }];

    return blurView;
}

+ (CGRect)contentRectForView:(UIView *)baseView onSuperView:(UIView *)superView withOrientation:(UIInterfaceOrientation)currentOrientaion
{
    CGFloat heightRatio = baseView.frame.size.height / superView.frame.size.height;
    CGFloat widthRatio = baseView.frame.size.width / superView.frame.size.width;
    
    CGPoint convertedPoint = [baseView convertPoint:CGPointZero toView:superView];

    CGFloat xRatio = convertedPoint.x / superView.frame.size.width;
    CGFloat yRatio = convertedPoint.y / superView.frame.size.height;
    
    
//    if (currentOrientaion == UIInterfaceOrientationLandscapeLeft | currentOrientaion == UIInterfaceOrientationLandscapeRight)
//    {
//        heightRatio = baseView.frame.size.height / superView.frame.size.width;
//        widthRatio = baseView.frame.size.width / superView.frame.size.height;
//        xRatio = convertedPoint.x / superView.frame.size.height;
//        yRatio = convertedPoint.y / superView.frame.size.width;
//    }
//    
    xRatio = MIN(xRatio, 1);
    yRatio = MIN(yRatio, 1);
    
    return CGRectMake(xRatio, yRatio, widthRatio, heightRatio);
}

@end
