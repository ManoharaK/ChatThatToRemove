//
//  SocialLoginViewController.m
//  ChatThat
//
//  Created by Varghese Simon on 5/6/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "SocialLoginViewController.h"
#import "ManualRegisterationViewController.h"
#import "SearchingAnswerersViewController.h"
#import "SearchQuestionsViewController.h"

@interface SocialLoginViewController ()

@end

@implementation SocialLoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)socailLoginPressed:(UIButton *)sender
{
    if (self.askingQuestion)
    {
        [self performSegueWithIdentifier:@"searchingAnswersSegue" sender:sender];
    }else
    {
        [self performSegueWithIdentifier:@"searchQuestionsSegue" sender:sender];
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"searchingAnswersSegue"])
    {
        SearchingAnswerersViewController *searchingAnsView = (SearchingAnswerersViewController *)segue.destinationViewController;
        searchingAnsView.questionForDisplaing = self.questionsToAsk;
        
    }else if ([segue.identifier isEqualToString:@"searchQuestionsSegue"])
    {
//        SearchQuestionsViewController *searchingQusView = (SearchQuestionsViewController *)segue.destinationViewController;
        
    }else if ([segue.identifier isEqualToString:@"manualLoginSegue"])
    {
        ManualRegisterationViewController *manualRegister = (ManualRegisterationViewController *)segue.destinationViewController;
        manualRegister.questionsToAsk = self.questionsToAsk;
        manualRegister.getQusKeywords = self.getQusKeywords;
        manualRegister.askingQuestion = self.askingQuestion;
    }
}

@end
