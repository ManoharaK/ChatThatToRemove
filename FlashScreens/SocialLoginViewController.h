//
//  SocialLoginViewController.h
//  ChatThat
//
//  Created by Varghese Simon on 5/6/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialLoginViewController : UIViewController

@property (strong, nonatomic) NSString *questionsToAsk;
@property (strong, nonatomic) NSArray *getQusKeywords;
@property (assign, nonatomic) BOOL askingQuestion;

@end
