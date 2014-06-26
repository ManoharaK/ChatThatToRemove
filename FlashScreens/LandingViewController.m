//
//  LandingViewController.m
//  FlashScreens
//
//  Created by Varghese Simon on 4/29/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "LandingViewController.h"

@interface LandingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *chatThatButton;
@property (weak, nonatomic) IBOutlet UITextView *infoLabel;

@end

@implementation LandingViewController

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
    
    [self setUpSkipButton:self.chatThatButton];
    [self updateLabel];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUpSkipButton:(UIButton *)skipButton
{
    skipButton.layer.borderColor = [UIColor colorWithRed:0.53 green:.81 blue:.99 alpha:1].CGColor;
    skipButton.layer.borderWidth = 1;
    skipButton.layer.cornerRadius = 5;
}

- (void)updateLabel
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSInteger noOfTopics = 6398;
    NSString *topicsText = [NSString stringWithFormat:@"%li topics", (long)noOfTopics];
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
    NSAttributedString *topicsAttText = [[NSAttributedString alloc] initWithString:topicsText attributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle}];
    
    NSString *infoTextWithOutTopics = @"245908 people from 29 countries \n are talking about \n";
    NSMutableAttributedString *infoText = [[NSMutableAttributedString alloc] initWithString:infoTextWithOutTopics attributes:@{NSParagraphStyleAttributeName: paragraphStyle}];
    [infoText appendAttributedString:topicsAttText];
    
    self.infoLabel.attributedText = infoText;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
