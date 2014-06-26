//
//  SelectQuestionsViewController.m
//  ChatThat
//
//  Created by Varghese Simon on 5/2/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "SelectQuestionsViewController.h"

@interface SelectQuestionsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SelectQuestionsViewController
{
    NSInteger maxNumberOfPages;
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
    
    maxNumberOfPages = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveToAnotherQuestion:(UIButton *)sender
{
    if (sender.tag == 101)
    {
        [self moveToNextPage];
    }else if (sender.tag == 100)
    {
        [self moveToPreviousPage];
    }
}

- (void)moveToNextPage
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger pageNumber = (NSInteger)floor(self.scrollView.contentOffset.x/pageWidth);
    
    NSInteger nextPageNumber = pageNumber + 1;
    
    if (nextPageNumber < maxNumberOfPages)
    {
        CGPoint nextContentOffset = CGPointMake(pageWidth * nextPageNumber, self.scrollView.contentOffset.y);
        [self.scrollView setContentOffset:nextContentOffset animated:YES];
    }

    NSLog(@"%i", pageNumber);
}

- (void)moveToPreviousPage
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger pageNumber = (NSInteger)floor(self.scrollView.contentOffset.x/pageWidth);
    
    NSInteger previousPageNumber = pageNumber - 1;
    
    if (previousPageNumber >= 0)
    {
        CGPoint nextContentOffset = CGPointMake(pageWidth * previousPageNumber, self.scrollView.contentOffset.y);
        [self.scrollView setContentOffset:nextContentOffset animated:YES];
    }
    
    NSLog(@"%i", pageNumber);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
