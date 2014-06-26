//
//  CellForMyIntersetS.h
//  ChatThat
//
//  Created by Varghese Simon on 5/29/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//
#import "RateView.h"
#import <UIKit/UIKit.h>

@interface CellForMyIntersetS : UITableViewCell <RateViewDelegate>

@property (strong, nonatomic) NSString *interestName;
@property (assign, nonatomic) NSInteger rateingOfInterest;
@property (assign, nonatomic) BOOL editable;
@property (weak, nonatomic) id<UITextFieldDelegate> delegateOfTextField;

@end
