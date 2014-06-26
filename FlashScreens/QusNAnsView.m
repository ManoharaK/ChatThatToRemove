//
//  QnAView.m
//  CustomPopoverView
//
//  Created by Varghese Simon on 6/4/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "QusNAnsView.h"
#import "ChatRoomViewController.h"

#import "BlurEffect.h"

#define WANTSTOANSCOLOR [UIColor redColor]
#define MYQUSCOLOR [UIColor blueColor]

@implementation QusNAnsView
{
    UIButton *leftButton;
    UIButton *rightButton;
    
    WYPopoverController *wantToAnsPopoverController, *myQusPopoverController;
    UIInterfaceOrientation currentOrienrarion;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initializeView];
}

- (void)initializeView
{
    leftButton = [[UIButton alloc] initWithFrame:(CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height))];
    [leftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    leftButton.backgroundColor = [UIColor blueColor];
    
    rightButton = [[UIButton alloc] initWithFrame:(CGRectMake(leftButton.frame.size.width, 0, self.frame.size.width/2, self.frame.size.height))];
    [rightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    rightButton.backgroundColor = [UIColor redColor];
    
    leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:leftButton];
    [self addSubview:rightButton];

    UIDevice *currentDevice = [UIDevice currentDevice];
    [currentDevice beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    currentOrienrarion = [UIApplication sharedApplication].statusBarOrientation;
    

    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(rightButton, leftButton);
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[leftButton(==rightButton)][rightButton]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    [self addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftButton]|"
                                                          options:0
                                                          metrics:nil
                                                            views:viewsDictionary];
    [self addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightButton]|"
                                                          options:0
                                                          metrics:nil
                                                            views:viewsDictionary];
    [self addConstraints:constraints];
    
//    NSLog(@"%@",self.constraints);
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    leftButton.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
    rightButton.frame = CGRectMake(leftButton.frame.size.width, 0, self.frame.size.width/2, self.frame.size.height);

}

- (void)didRotate:(NSNotification *)notification
{
    currentOrienrarion = [UIApplication sharedApplication].statusBarOrientation;
    
    [wantToAnsPopoverController dismissPopoverAnimated:YES completion:^{
        wantToAnsPopoverController.delegate = nil;
        wantToAnsPopoverController = nil;
    }];
    
    [myQusPopoverController dismissPopoverAnimated:YES completion:^{
        myQusPopoverController.delegate = nil;
        myQusPopoverController = nil;
    }];
}

- (void)updateConstraints
{
    [super updateConstraints];
}

- (void)leftButtonPressed:(UIButton *)sender
{
    UIView *btn = (UIView *)sender;
    
    if (myQusPopoverController == nil)
    {
        MyQuestionsViewController *myQuestionVC = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionStoryBoardID"];
        myQuestionVC.delegate = self;
        
        CGSize contentSize = CGSizeMake(300,200);
        
        if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            myQuestionVC.contentSizeForViewInPopover = contentSize;
        }else
        {
            myQuestionVC.preferredContentSize = contentSize;
        }
        
        myQusPopoverController = [[WYPopoverController alloc] initWithContentViewController:myQuestionVC];
        myQusPopoverController.delegate = self;
        myQusPopoverController.passthroughViews = @[btn];
        myQusPopoverController.theme = [WYPopoverTheme themeForIOS7];
        [myQusPopoverController presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:(WYPopoverArrowDirectionAny) animated:YES options:(WYPopoverAnimationOptionFadeWithScale)];
        
        [BlurEffect blurredImageOfView:self.parentViewController.view onBaseView:myQuestionVC.view withTintColor:MYQUSCOLOR];

    }else
    {
        [myQusPopoverController dismissPopoverAnimated:YES completion:^{
            myQusPopoverController.delegate = nil;
            myQusPopoverController = nil;
        }];
    }
}

- (void)rightButtonPressed:(UIButton *)sender
{
    UIView *btn = (UIView *)sender;
    if (wantToAnsPopoverController == nil)
    {
        WantToAnswerViewController *wantToAnswerVC = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"WantToAnswerStoryBoardId"];
        wantToAnswerVC.delegate = self;
        
        CGSize contentSize = CGSizeMake(300,460);
        
        if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            wantToAnswerVC.contentSizeForViewInPopover = contentSize;
        }else
        {
            wantToAnswerVC.preferredContentSize = contentSize;
        }
        
        wantToAnsPopoverController = [[WYPopoverController alloc] initWithContentViewController:wantToAnswerVC];
        wantToAnsPopoverController.delegate = self;
        wantToAnsPopoverController.passthroughViews = @[btn];
        wantToAnsPopoverController.theme = [WYPopoverTheme themeForIOS7];
        [wantToAnsPopoverController presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:(WYPopoverArrowDirectionAny) animated:YES options:(WYPopoverAnimationOptionFadeWithScale)];
        
        [BlurEffect blurredImageOfView:self.parentViewController.view onBaseView:wantToAnswerVC.view withTintColor:WANTSTOANSCOLOR];
        
    }else
    {
        [wantToAnsPopoverController dismissPopoverAnimated:YES completion:^{
            wantToAnsPopoverController.delegate = nil;
            wantToAnsPopoverController = nil;
        }];
    }
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)popoverController
{
    if (popoverController == wantToAnsPopoverController)
    {
        wantToAnsPopoverController.delegate = nil;
        wantToAnsPopoverController = nil;
    }else if (popoverController == myQusPopoverController)
    {
        myQusPopoverController.delegate = nil;
        myQusPopoverController = nil;
    }
}

- (void)updateBlur
{
    if (wantToAnsPopoverController != nil)
    {
        [BlurEffect blurredImageOfView:self.parentViewController.view onBaseView:wantToAnsPopoverController.contentViewController.view withTintColor:WANTSTOANSCOLOR];
    }
    
    if (myQusPopoverController != nil)
    {
        [BlurEffect blurredImageOfView:self.parentViewController.view onBaseView:myQusPopoverController.contentViewController.view withTintColor:MYQUSCOLOR];
    }
}

- (void)popOverVCWithName:(NSString *)name DidSelectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@ %@",indexPath, name);
    
    if ([name isEqualToString:MYQUSVSID])
    {
        
    }else if ([name isEqualToString:WANTSTOANSVCID])
    {
        
    }
    
    if ([self.parentViewController isKindOfClass:[ChatRoomViewController class]])
    {
        NSLog(@"Chat room");
    }else
    {
        NSLog(@"Parent viewcontroller is not chat room");
    }
}

@end
