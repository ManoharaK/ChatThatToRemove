//
//  MyProfileViewController.m
//  ChatThat
//
//  Created by Varghese Simon on 5/28/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "MyProfileViewController.h"
#import "CellForMyIntersetS.h"
#import <pop/POP.h>

@interface MyProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameOfUser;
@property (weak, nonatomic) IBOutlet UITextField *emailID;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirth;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *ratingsOfMineView;
@property (weak, nonatomic) IBOutlet UIButton *allRatingShowButton;
@property (weak, nonatomic) IBOutlet UIButton *questionRatingShowButton;
@property (weak, nonatomic) IBOutlet UIButton *answerRatingShowButton;
@property (weak, nonatomic) IBOutlet UITableView *tableViewForMyInterest;
@property (weak, nonatomic) IBOutlet UITableView *tableViewForSuggestedInterests;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContainerHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewToSuperTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableInterestHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *suggestedInterestHeightConst;

@property (weak, nonatomic) IBOutlet QusNAnsView *qusNAnsView;

@end

@implementation MyProfileViewController
{
    UIButton *previousSelectedButton;
    
    NSMutableArray *dataWithListOfInterests, *dataWithListOfRateings, *dataSuggestedList;
    CGPoint contentOffsetToReset;
    BOOL editingEnabled;
    NSInteger topOfKeyboard;
    UIBarButtonItem *editBarButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)slideOutbuttonPressed:(id)sender
{
    [self.revealViewController revealToggleAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    editBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:(UIBarButtonItemStylePlain) target:self action:@selector(toggleEditing:)];
    self.navigationItem.rightBarButtonItem = editBarButton;
    self.ratingsOfMineView.layer.borderColor = [UIColor blackColor].CGColor;
    self.ratingsOfMineView.layer.borderWidth = 1.0f;
    self.ratingsOfMineView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.ratingsOfMineView.layer.shadowOffset = CGSizeMake(0, 0);
    self.ratingsOfMineView.layer.shadowOpacity = .7;
    self.ratingsOfMineView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.ratingsOfMineView.bounds].CGPath;
    self.ratingsOfMineView.layer.shadowRadius = 3;
    
    [self setImage:@"ratingInMyProButtom.png" forButton:self.allRatingShowButton];
    [self setImage:@"ratingInMyProButtom.png" forButton:self.questionRatingShowButton];
    [self setImage:@"ratingInMyProButtom.png" forButton:self.answerRatingShowButton];
    
    previousSelectedButton = self.allRatingShowButton;
    [self showRatings:previousSelectedButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        self.scrollViewToSuperTopConst.constant = -64.0f;
    }
    
    topOfKeyboard = self.view.frame.size.height - (216 + 100);
    
//Aribitary data to be shown
    dataWithListOfInterests = [@[@"Outdoor photography", @"Camera lens", @"Advetnture sports", @"Japanise cinema", @"Thai resturent in SanJose", @"Indian Cricket"] mutableCopy];
    dataWithListOfRateings = [@[@1, @2, @1, @3, @2,@3] mutableCopy];
    
    dataSuggestedList = [@[@"Egypt Tourism", @"Suzuki V-Strom 650", @"iOS development"]mutableCopy];
    
    self.qusNAnsView.parentViewController = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshTableView];
    [self refreshSuggestedTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self updateContainerViewInScrollView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [self makeTextFieldsNotEditable];
    [self dismissKeyboard];
    editBarButton.title = @"Edit";
}

- (void)setImage:(NSString *)imageName forButton:(UIButton *)button
{
    [button setBackgroundImage:[[UIImage imageNamed:imageName] resizableImageWithCapInsets:(UIEdgeInsetsMake(12, 12, 12, 12))]forState:(UIControlStateSelected)];
    [button setBackgroundImage:[[UIImage imageNamed:@"ratingInMyProButtomNotSelected.png"] resizableImageWithCapInsets:(UIEdgeInsetsMake(12, 12, 12, 12))]forState:(UIControlStateNormal)];
    button.adjustsImageWhenHighlighted = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleEditing:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"Edit"])
    {
        [self makeTextFiledsEditable];
        sender.title = @"Done";
    }else if ([sender.title isEqualToString:@"Done"])
    {
        [self makeTextFieldsNotEditable];
        [self dismissKeyboard];
        sender.title = @"Edit";
    }
}

- (void)makeTextFiledsEditable
{
    editingEnabled = YES;
    [self makeTextField:self.nameOfUser editable:YES];
    [self makeTextField:self.emailID editable:YES];
    [self makeTextField:self.location editable:YES];
    [self makeTextField:self.dateOfBirth editable:YES];
    [self makeTextField:self.gender editable:YES];
    [self refreshTableView];
}

- (void)makeTextFieldsNotEditable
{
    editingEnabled = NO;
    [self makeTextField:self.nameOfUser editable:NO];
    [self makeTextField:self.emailID editable:NO];
    [self makeTextField:self.location editable:NO];
    [self makeTextField:self.dateOfBirth editable:NO];
    [self makeTextField:self.gender editable:NO];
    [self refreshTableView];
}

- (void)makeTextField:(UITextField *)textField editable:(BOOL)editable
{
    if (editable)
    {
        textField.userInteractionEnabled = YES;
        textField.borderStyle = UITextBorderStyleBezel;
    }else
    {
        textField.userInteractionEnabled = NO;
        textField.borderStyle = UITextBorderStyleLine;
        textField.borderStyle = UITextBorderStyleNone;
    }
}

- (IBAction)showRatings:(UIButton *)sender
{
    if (!sender.isSelected)
    {
        [self animateFallBackOfButton];
        
        sender.layer.zPosition = 1;

        [self springAnimationToView:sender ForProperty:kPOPLayerScaleXY toValue:[NSValue valueWithCGSize:(CGSizeMake(1.05, 1.05))] withName:@"springZoom"];
        
        sender.selected = YES;
        previousSelectedButton = sender;
    }
}

- (void)animateFallBackOfButton
{
    [self springAnimationToView:previousSelectedButton ForProperty:kPOPLayerScaleXY toValue:[NSValue valueWithCGSize:(CGSizeMake(1, 1))] withName:@"springZoomOut"];
    previousSelectedButton.layer.zPosition = 0;
    previousSelectedButton.selected = NO;
}

- (void)springAnimationToView:(UIView *)view ForProperty:(NSString *)property toValue:(id)toValue withName:(NSString *)nameOfAnimation
{
    [view.layer removeAllAnimations];
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:property];
    springAnimation.toValue = toValue;
    springAnimation.springBounciness = 20.0f;
    springAnimation.springSpeed = 20;
    springAnimation.dynamicsTension = 1000;
    
    [view.layer pop_addAnimation:springAnimation forKey:nameOfAnimation];
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

- (void)refreshTableView
{
    [self.tableViewForMyInterest reloadData];
    [self adjustHeightOfTable:self.tableViewForMyInterest withHeightConstrain:self.tableInterestHeightConst];
}

- (void)refreshSuggestedTableView
{
    [self.tableViewForSuggestedInterests reloadData];
    [self adjustHeightOfTable:self.tableViewForSuggestedInterests withHeightConstrain:self.suggestedInterestHeightConst];
}

- (void)updateContainerViewInScrollView
{
    CGFloat heigthOfContainerView = self.tableViewForSuggestedInterests.frame.origin.y + self.suggestedInterestHeightConst.constant + 10;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollContainerHeightConst.constant = heigthOfContainerView;
        [self.view needsUpdateConstraints];
    }];
}

- (void)adjustHeightOfTable:(UITableView *)tableView withHeightConstrain:(NSLayoutConstraint *)heightConst
{
    CGFloat height = tableView.contentSize.height;
    CGFloat maxHeight = 500;
    
    if (height > maxHeight)
    {
        height = maxHeight;
    }
    
    [UIView animateWithDuration:.25
                     animations:^{
                         heightConst.constant = height;
                         [self.view needsUpdateConstraints];
                     }
                     completion:^(BOOL finished) {
                         [self updateContainerViewInScrollView];;
                     }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableViewForMyInterest])
    {
        return [dataWithListOfInterests count];
    }
    return [dataSuggestedList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if ([tableView isEqual:self.tableViewForMyInterest])
    {
        CellForMyIntersetS *cellOfInterest = (CellForMyIntersetS *)cell;
        
        cellOfInterest.interestName = dataWithListOfInterests[indexPath.row];
        cellOfInterest.editable = editingEnabled;
        cellOfInterest.rateingOfInterest = [dataWithListOfRateings[indexPath.row] integerValue];
        cellOfInterest.delegateOfTextField = self;
        cell = cellOfInterest;
    }else
    {
        UILabel *suggestedInstLabel = (UILabel *)[cell viewWithTag:100];
        suggestedInstLabel.text = dataSuggestedList[indexPath.row];
    }
    return cell;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint originOfTextField = [textField convertPoint:(CGPointZero) toView:self.view];
    
    if (originOfTextField.y > topOfKeyboard)
    {
        CGFloat delta = originOfTextField.y - topOfKeyboard;
        [self scrollByPoints:delta];
    }
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)keyboardWillShow
{
    contentOffsetToReset = self.scrollView.contentOffset;
}

- (void)keyboardWillHide
{
    [self.scrollView setContentOffset:contentOffsetToReset animated:YES];
}

- (void)scrollByPoints:(NSInteger)delta
{
    CGPoint currentContentOffset = self.scrollView.contentOffset;
    currentContentOffset.y += delta;
    [self.scrollView setContentOffset:currentContentOffset animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
@end
