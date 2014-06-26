//
//  NaviagtionDrawerViewController.m
//  ChatThat
//
//  Created by Varghese Simon on 5/12/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "NaviagtionDrawerViewController.h"

@interface NaviagtionDrawerViewController ()
{
    NSArray *menuNamesArr, *menuStoryBordID;
}
@property (weak, nonatomic) IBOutlet UITableView *menuItemsTableView;

@end

@implementation NaviagtionDrawerViewController

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
    menuNamesArr = @[@"Home",@"My Profile",@"Settings",@"History(Chat log)",
                     @"Log Out"];
    menuStoryBordID = @[@"slideOutHistorySegue",@"sildeOutMyPorfilePafeSegue",@"slideOutHistorySegue",@"slideOutHistorySegue",@"slideOutHistorySegue",];
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
    NSIndexPath *indexPath = [self.menuItemsTableView indexPathForSelectedRow];
    UINavigationController *destinationViewController = (UINavigationController*)segue.destinationViewController;
    destinationViewController.title = [menuNamesArr objectAtIndex:indexPath.row];
    
    if ([segue isKindOfClass:[SWRevealViewControllerSegue class]])
    {
        SWRevealViewControllerSegue *revelSegue = (SWRevealViewControllerSegue *)segue;
        
        SWRevealViewController *revelViewCOntroller = self.revealViewController;
        revelSegue.performBlock = ^( SWRevealViewControllerSegue* segue, UIViewController* svc, UIViewController* dvc )
        {
            [dvc.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
            [dvc.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
           
            UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.revealViewController action:@selector(revealToggle:)];
            dvc.navigationItem.leftBarButtonItem = revealButtonItem;
            
            UINavigationController *naviagtionController = [[UINavigationController alloc] initWithRootViewController:dvc];
            [revelViewCOntroller pushFrontViewController:naviagtionController animated:YES];
//            UINavigationController *naviagtionController = (UINavigationController*)self.revealViewController.frontViewController;
//            [naviagtionController setViewControllers: @[dvc] animated: NO ];
//            [revelViewCOntroller setFrontViewPosition:FrontViewPositionLeft animated:YES];
        };
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UILabel *lable = (UILabel*)[cell viewWithTag:100];
    lable.text = menuNamesArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:menuStoryBordID[indexPath.row] sender:tableView];
}
@end
