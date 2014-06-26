//
//  ViewController.m
//  FlashScreens
//
//  Created by Varghese Simon on 4/29/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define numberOfFlashScreens 3

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *skipButton1;
@property (weak, nonatomic) IBOutlet UIButton *skipButton2;
@property (weak, nonatomic) IBOutlet UIView *chatLogoView;
@property (weak, nonatomic) IBOutlet UIView *firstFlashView;
@property (weak, nonatomic) IBOutlet UIView *secondFlashView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeightConst;

@property (weak, nonatomic) IBOutlet UIView *containerViewInScroll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTopConst;
@end

@implementation ViewController
{
    BOOL firstTimerUser;
    NSTimer *timer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        // app already launched
        NSLog(@"Not first launch");
        firstTimerUser = NO;
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // This is the first launch ever
        NSLog(@"First launch");
        
        firstTimerUser = YES;
    }
    
    [self setUpSkipButton:self.skipButton2];
    [self setUpSkipButton:self.skipButton1];
    self.pageController.currentPage = 0;
    
    CGSize singleViewSize = self.firstFlashView.frame.size;
    
    CGRect frameOfContainerView = self.containerViewInScroll.frame;
    frameOfContainerView.size = CGSizeMake(singleViewSize.width*numberOfFlashScreens, singleViewSize.height);
    self.containerViewWidthConst.constant = singleViewSize.width*numberOfFlashScreens;
    
     timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerIsFired:) userInfo:nil repeats:NO];

    self.navigationController.navigationBarHidden = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
        self.containerViewHeightConst.constant = 480;
    }
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        self.scrollViewTopConst.constant = -20;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSkipButton:(UIButton *)skipButton
{
    skipButton.layer.borderColor = [UIColor blackColor].CGColor;
    skipButton.layer.borderWidth = 1;
    skipButton.layer.cornerRadius = 15;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updatePageController];
}

- (void)updatePageController
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    if (page != 0)
    {
        [timer invalidate];
    }
    
    // Update the page control
    self.pageController.currentPage = page;
}
- (IBAction)pageControllerValueChanged:(UIPageControl *)sender
{
    NSInteger pageNumber = sender.currentPage;
    [self moveToPage:pageNumber];
}

- (void)moveToPage:(NSInteger)pageNumber
{
    CGPoint currentDisplayPoint = CGPointMake(pageNumber * 320, 0);
    [self.scrollView setContentOffset:currentDisplayPoint animated:YES];
}

- (IBAction)skipButtonPressed:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"landingScreenSegue" sender:self];
}

- (void)timerIsFired:(NSTimer *)firedTimer
{
    if (firstTimerUser)
    {
        [self moveToPage:1];
    }else
    {
        [self performSegueWithIdentifier:@"landingScreenSegue" sender:self];
    }
}

@end
