//
//  QnAView.h
//  CustomPopoverView
//
//  Created by Varghese Simon on 6/4/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPopoverController.h"
#import "MyQuestionsViewController.h"
#import "WantToAnswerViewController.h"

#define WANTSTOANSVCID @"wantToAnsVC"
#define MYQUSVSID @"mYQusVC"

@protocol QnAViewDelegate <NSObject>

@end


@interface QusNAnsView : UIView <WYPopoverControllerDelegate, PopOverVCProtocol>

@property (strong, nonatomic) NSString *leftTitle;
@property (strong, nonatomic) NSString *rightTitle;


//NOTE: use this property
@property (weak, nonatomic) UIViewController *parentViewController;

- (void)updateBlur;

@end
