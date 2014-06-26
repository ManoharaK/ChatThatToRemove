//
//  ChatRoomViewController.m
//  ChatThat
//
//  Created by Varghese Simon on 5/9/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "WYPopoverController.h"
#import "MyQuestionsViewController.h"
#import "WantToAnswerViewController.h"
#import "ChatSubMenuViewController.h"


@interface ChatRoomViewController ()
{
    WYPopoverController *popOverController;
}

@property (nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (weak, nonatomic) IBOutlet UIBubbleTableView *bubbleTable;
@property (weak, nonatomic) IBOutlet QusNAnsView *qusNAnsView;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendMsgButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatViewBottomConst;
@end

@implementation ChatRoomViewController
{
    NSMutableArray *bubbleData;
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
    self.revealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = self.revealButtonItem;
    
    NSArray *arrayOfGestureRecoginzers = self.view.gestureRecognizers;
    
    if (![arrayOfGestureRecoginzers containsObject:self.revealViewController.panGestureRecognizer])
    {
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    
    if (![arrayOfGestureRecoginzers containsObject:self.revealViewController.tapGestureRecognizer])
    {
        [self.view addGestureRecognizer: self.revealViewController.tapGestureRecognizer];
    }
    
    NSBubbleData *heyBubble = [NSBubbleData dataWithText:@"Hey, halloween is soon" date:[NSDate dateWithTimeIntervalSinceNow:-300] type:BubbleTypeSomeoneElse];
    heyBubble.avatar = [UIImage imageNamed:@"avatar1.png"];
    
    NSBubbleData *photoBubble = [NSBubbleData dataWithImage:[UIImage imageNamed:@"halloween.jpg"] date:[NSDate dateWithTimeIntervalSinceNow:-290] type:BubbleTypeSomeoneElse];
    photoBubble.avatar = [UIImage imageNamed:@"avatar1.png"];
    
    NSBubbleData *replyBubble = [NSBubbleData dataWithText:@"Wow.. Really cool picture out there. iPhone 5 has really nice camera, yeah?" date:[NSDate dateWithTimeIntervalSinceNow:-5] type:BubbleTypeMine];
    replyBubble.avatar = nil;
    
    bubbleData = [[NSMutableArray alloc] initWithObjects:heyBubble, photoBubble, replyBubble, nil];
    self.bubbleTable.snapInterval = 40;
    self.bubbleTable.showAvatars = YES;
    [self.bubbleTable reloadData];
    
    self.qusNAnsView.parentViewController = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.sendMsgButton.enabled = NO;
}

- (IBAction)chatSubBtnAction:(UIButton *)sender {
    UIView *btn = (UIView *)sender;
    
    ChatSubMenuViewController *chatSubMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatSubMenutoryoardID"];
    
    CGSize contentSize = CGSizeMake(160,175);
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        chatSubMenuVC.contentSizeForViewInPopover = contentSize;
    }else
    {
        chatSubMenuVC.preferredContentSize = contentSize;
    }
    
    popOverController = [[WYPopoverController alloc] initWithContentViewController:chatSubMenuVC];
    popOverController.delegate = self;
    popOverController.passthroughViews = @[btn];
    popOverController.theme = [WYPopoverTheme themeForIOS7];
    popOverController.theme.arrowHeight = 10;
    popOverController.theme.arrowBase= 0;
    popOverController.theme.overlayColor= [UIColor clearColor];
    
    [popOverController presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:(WYPopoverArrowDirectionAny) animated:YES options:(WYPopoverAnimationOptionFadeWithScale)];
    
    [BlurEffect blurredImageOfView:self.view onBaseView:chatSubMenuVC.view withTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [bubbleData count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleData objectAtIndex:row];
}

- (IBAction)sendMessage:(UIButton *)sender
{
    NSBubbleData *dataFromTextField = [NSBubbleData dataWithText:self.chatTextField.text date:([NSDate date]) type:(BubbleTypeMine)];
    dataFromTextField.avatar = nil;
    
    [bubbleData addObject:dataFromTextField];
    [self.bubbleTable reloadData];
    self.chatTextField.text = @"";

    [self textField:self.chatTextField shouldChangeCharactersInRange:(NSMakeRange(0, 0)) replacementString:@""];
    [self showLastMessageOnChatWindow];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *stringFromText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (stringFromText.length == 0)
    {
        self.sendMsgButton.enabled = NO;
    }
    else
    {
        self.sendMsgButton.enabled = YES;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self adjustForKeybordToCome];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resetAfterKeyboardHadGone];
}

- (void)adjustForKeybordToCome
{
    self.chatViewBottomConst.constant += 115;
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:.4
          initialSpringVelocity:1
                        options:(UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [self showLastMessageOnChatWindow];
                     }];
}

- (void)resetAfterKeyboardHadGone
{
    self.chatViewBottomConst.constant -= 115;
    
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:.4
          initialSpringVelocity:.7
                        options:(UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [self showLastMessageOnChatWindow];
                     }];
    
    [self showLastMessageOnChatWindow];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)showLastMessageOnChatWindow
{
    CGFloat heightOfTable = self.bubbleTable.frame.size.height;
    CGFloat heightOfContentInTable = self.bubbleTable.contentSize.height;
    
    if (heightOfContentInTable > heightOfTable)
    {
        CGFloat offsetForScrolling = heightOfContentInTable - heightOfTable;
        
        CGPoint contentOffset = self.bubbleTable.contentOffset;
        contentOffset.y = offsetForScrolling;
        
        [self.bubbleTable setContentOffset:contentOffset animated:YES];
    }
    else
    {
        [self.bubbleTable setContentOffset:(CGPointZero) animated:YES];
    }
}

@end
