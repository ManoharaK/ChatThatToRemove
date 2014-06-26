//
//  SearchingAnswerersViewController.m
//  ChatThat
//
//  Created by Varghese Simon on 5/2/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "SearchingAnswerersViewController.h"

@interface SearchingAnswerersViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation SearchingAnswerersViewController
{
    NSTimer *timer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.questionLabel.text = self.questionForDisplaing;
    [self.activityView startAnimating];
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(naviagteToNextView:) userInfo:nil repeats:NO];
}

- (void)naviagteToNextView:(NSTimer *)firedTimer
{
    [self.activityView stopAnimating];
    NSLog(@"Navigating to nextView");
    [self performSegueWithIdentifier:@"searchToChatRoomSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [timer invalidate];
}

@end
