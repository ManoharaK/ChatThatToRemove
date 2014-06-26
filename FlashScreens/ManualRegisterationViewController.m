//
//  ManualRegisterationViewController.m
//  ChatThat
//
//  Created by Varghese Simon on 5/7/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "ManualRegisterationViewController.h"
#import "SearchingAnswerersViewController.h"

@interface ManualRegisterationViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstnameTopConst;

@end

@implementation ManualRegisterationViewController

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        self.firstnameTopConst.constant = 20;
    }
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButtonPressed:(UIButton *)sender
{
    if (self.askingQuestion)
    {
        [self performSegueWithIdentifier:@"RegisterToSearchingAnswersSegue" sender:sender];
    }else
    {
        [self performSegueWithIdentifier:@"registerToSearchQuestionsSegue" sender:sender];
    }
}

- (IBAction)backButtonIsPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"RegisterToSearchingAnswersSegue"])
    {
        SearchingAnswerersViewController *searchingAnsrVC = (SearchingAnswerersViewController *)segue.destinationViewController;
        searchingAnsrVC.questionForDisplaing = self.questionsToAsk;
    }
}

@end
