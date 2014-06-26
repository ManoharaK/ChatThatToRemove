//
//  WantToAnswerViewController.h
//  ChatThat
//
//  Created by Varghese Simon on 5/26/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyQuestionsViewController.h"

@interface WantToAnswerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic)id<PopOverVCProtocol> delegate;

@end
