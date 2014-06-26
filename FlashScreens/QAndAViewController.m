//
//  QAndAViewController.m
//  FlashScreens
//
//  Created by Varghese Simon on 4/30/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "QAndAViewController.h"
#import "SocialLoginViewController.h"
#define kOFFSET_FOR_KEYBOARD 225.0


@interface QAndAViewController ()
@property (weak, nonatomic) IBOutlet UITextView *askStaticTextView;
@property (weak, nonatomic) IBOutlet UITextView *questionAskTextView;
@property (weak, nonatomic) IBOutlet UITextView *getStaticTextView;
@property (weak, nonatomic) IBOutlet UITextView *getQuestionKeyTextView;
@property (weak, nonatomic) IBOutlet UIButton *askButton;
@property (weak, nonatomic) IBOutlet UIButton *getQuestionsButton;
@property (weak, nonatomic) IBOutlet UIButton *parameterButton;
@property (weak, nonatomic) IBOutlet UIButton *addInterestButton;
@property (weak, nonatomic) IBOutlet UIButton *myLocationButton;
@property (weak, nonatomic) IBOutlet UIButton *maleOnlyButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleOnlyButton;
@property (weak, nonatomic) IBOutlet UILabel *withinMilesLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearInRangeLabel;
@property (weak, nonatomic) IBOutlet UISlider *withinRadiusSlider;
@property (weak, nonatomic) IBOutlet UISlider *yearsinRangeSlider;

@property (weak, nonatomic) IBOutlet UIView *getQuestionView;
@property (weak, nonatomic) IBOutlet UIView *askQuestionView;
@property (weak, nonatomic) IBOutlet UIScrollView *parameterScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *questionGetViewTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getQuestionsButtonBottomConst;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getKeywordsTextViewTopConst;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getKeywordsTextViewBottomConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *askSomethingStaticTextViewTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *questionAskViewTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getQusTextFieldTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getQusTextViewBottomConsr;
@property (weak, nonatomic) IBOutlet UIView *containerOfGetQusTextVw;
@property (weak, nonatomic) IBOutlet UIView *containerOfAskQusTxtVw;
@end


@implementation QAndAViewController
{
    UITextView *currentTextView;
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
    self.title = @"Chat That";
    
    self.askStaticTextView.text = @"Ask something \n you want to get an answer";
    self.getStaticTextView.text = @"Type in few words you can\nhelp giving answers";

    self.questionAskTextView.delegate = self;
    self.getQuestionKeyTextView.delegate = self;
    
    self.askButton.layer.cornerRadius = 5;
    self.getQuestionsButton.layer.cornerRadius = 5;

//    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setImageForNormal:@"ParameterShowicon.png" andForSelected:@"parametersHideIcon.png" forButton:self.parameterButton];
    [self setImageForNormal:@"addInterestIcon.png" andForSelected:@"interestCheckMarkIcon.png" forButton:self.addInterestButton];
    [self setImageForNormal:@"uncheckedBox.png" andForSelected:@"checkbox.png" forButton:self.myLocationButton];
    [self setImageForNormal:@"radio-button-off.png" andForSelected:@"radio-button-on.png" forButton:self.maleOnlyButton];
    [self setImageForNormal:@"radio-button-off.png" andForSelected:@"radio-button-on.png" forButton:self.femaleOnlyButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.navigationController.navigationBarHidden = NO;
    
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
        self.questionGetViewTopConst.constant = 10;
        self.getQuestionsButtonBottomConst.constant = 10;
        
        self.getQusTextFieldTopConst.constant = 10;
        self.getQusTextViewBottomConsr.constant = 10;
        
//        self.getKeywordsTextViewBottomConst.constant = 10;
//        self.getKeywordsTextViewTopConst.constant = 10;
    }
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        self.addInterestButton.titleLabel.font = [UIFont systemFontOfSize:14];
        self.parameterButton.titleLabel.font = [UIFont systemFontOfSize:14];
        self.questionAskViewTopConst.constant = -64;
    }
    
    self.withinRadiusSlider.enabled = NO;
    self.withinMilesLabel.textColor = [UIColor lightGrayColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self giveShadowToView:self.containerOfAskQusTxtVw withOpacity:.2 andRadius:1];
    [self giveShadowToView:self.containerOfGetQusTextVw withOpacity:.2 andRadius:1];

    [self giveShadowToView:self.askQuestionView withOpacity:.4 andRadius:2];
    [self giveShadowToView:self.getQuestionView withOpacity:.4 andRadius:2];
    
    self.askQuestionView.layer.masksToBounds = YES;
    self.getQuestionView.layer.masksToBounds = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)setImageForNormal:(NSString *)normalImageName andForSelected:(NSString *)selectedImage forButton:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:normalImageName] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:selectedImage] forState:(UIControlStateSelected)];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}


- (void)giveShadowToView:(UIView *)view withOpacity:(CGFloat)opacity andRadius:(CGFloat)radius
{
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowOpacity = opacity;
    view.layer.shadowRadius = radius;
    view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)].CGPath;
//    self.view.layer.shouldRasterize = YES;
//    self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToInterest:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
}

- (IBAction)parameterButtonPressed:(UIButton *)sender
{
    if (!sender.isSelected)
    {
        [self showParameters];
    }else
    {
        [self hideParameters];
    }
//    sender.selected = !sender.isSelected;
}

- (void)showParameters
{
    self.parameterButton.selected = YES;

    self.askQuestionView.layer.masksToBounds = NO;
    self.getQuestionView.layer.masksToBounds = NO;
    
    CGFloat translatioin = self.view.frame.size.height - 100 - self.getQuestionView.frame.origin.y;
    
    CGRect frameOfParameterView = self.parameterScrollView.frame;
    frameOfParameterView.size.height = translatioin;
    self.parameterScrollView.frame = frameOfParameterView;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, translatioin, 0);
    [self animateView:self.getQuestionView withTransform:transform showShadow:YES];
}

- (void)showAnimationOfView:(UIView *)view toValue:(id)toValue withName:(NSString *)name
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
    springAnimation.toValue = toValue;
    springAnimation.springBounciness = 20.0f;
    springAnimation.springSpeed = 10;
    springAnimation.dynamicsTension = 100;
    
    [view.layer pop_addAnimation:springAnimation forKey:name];
    springAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        self.askQuestionView.layer.masksToBounds = NO;
        self.getQuestionView.layer.masksToBounds = NO;
    };
}

- (void)hideParameters
{
    self.parameterButton.selected = NO;
    [self.view endEditing:YES];
    [self animateView:self.getQuestionView withTransform:CATransform3DIdentity showShadow:NO];
}

- (void)animateView:(UIView *)view withTransform:(CATransform3D)transform showShadow:(BOOL)shadow
{
    [view.layer removeAllAnimations];
    [UIView animateWithDuration:.7 delay:0 options:(UIViewAnimationOptionBeginFromCurrentState) animations:^
    {
        view.layer.transform = transform;
        
    } completion:^(BOOL finished) {
        if (!shadow)
        {
            if (self.getQuestionView.frame.origin.y <= self.parameterScrollView.frame.origin.y)
            {
                self.askQuestionView.layer.masksToBounds = YES;
                self.getQuestionView.layer.masksToBounds = YES;
            }
        }else
        {
            self.askQuestionView.layer.masksToBounds = NO;
            self.getQuestionView.layer.masksToBounds = NO;
        }
    }];
}

- (IBAction)inMyLocation:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.withinRadiusSlider.enabled = sender.selected;
    
    if (!sender.selected)
    {
        self.withinMilesLabel.textColor = [UIColor lightGrayColor];
    }
    else
    {
        self.withinMilesLabel.textColor = [UIColor blackColor];
    }
    
}

- (IBAction)maleOnly:(UIButton *)sender
{
    if (!sender.selected)
    {
        self.femaleOnlyButton.selected = NO;
    }
    sender.selected = !sender.isSelected;
}

- (IBAction)femaleOnly:(UIButton *)sender
{
    if (!sender.selected)
    {
        self.maleOnlyButton.selected = NO;
    }
    sender.selected = !sender.isSelected;
}

- (IBAction)askButtonPressed:(UIButton *)sender
{
    [self.view endEditing:YES];
    NSLog(@"Ask button pressed");
    [self hideParameters];
    [self performSegueWithIdentifier:@"socialLoginScreenSegue" sender:sender];
}

- (IBAction)getQuestionsPressed:(UIButton *)sender
{
    [self hideParameters];
    [self.view endEditing:YES];
    NSLog(@"Get question button pressed");
    [self performSegueWithIdentifier:@"socialLoginScreenSegue" sender:sender];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 101)
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 101)
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
    [self.view endEditing:YES];
}


-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.parameterScrollView setContentOffset:(CGPointZero) animated:YES];
    
    if ([segue.identifier isEqualToString:@"socialLoginScreenSegue"])
    {
        SocialLoginViewController *socialLoginPage = (SocialLoginViewController *)segue.destinationViewController;
        if ([sender tag] == 100)
        {
            socialLoginPage.askingQuestion = YES;
            socialLoginPage.questionsToAsk = self.questionAskTextView.text;
        }else if ([sender tag] == 101)
        {
            socialLoginPage.askingQuestion = NO;
            socialLoginPage.getQusKeywords = @[@"My"];
        }
    }
}
- (IBAction)sliderValueChanged:(UISlider *)sender
{
    if ([sender isEqual:self.withinRadiusSlider])
    {
        if (sender.value < 5000)
        {
            self.withinMilesLabel.text = [NSString stringWithFormat:@"Search Within %i miles",(int)sender.value];
        }else
        {
            self.withinMilesLabel.text = [NSString stringWithFormat:@"Search in Whole World"];
        }
    }else if ([sender isEqual:self.yearsinRangeSlider])
    {
        if (sender.value < 100)
        {
            NSInteger maxAgeLimit = (NSInteger) sender.value;
            NSInteger minAgeLimit = (NSInteger) MAX(0, maxAgeLimit - 10);
            self.yearInRangeLabel.text = [NSString stringWithFormat:@"Age group of %i - %i years ", minAgeLimit, maxAgeLimit];
        }else
        {
            self.yearInRangeLabel.text = [NSString stringWithFormat:@"All age groups"];
        }
    }
}

@end
