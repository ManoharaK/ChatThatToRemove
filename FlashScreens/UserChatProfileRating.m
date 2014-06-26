//
//  UserChatProfileRating.m
//  ChatThat
//
//  Created by Varghese Simon on 6/25/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "UserChatProfileRating.h"
#import "RateView.h"

@interface UserChatProfileRating ()

@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *userLocation;
@property (strong, nonatomic) UIButton *rateUserButton;
@property (strong, nonatomic) RateView *userRateView;
@property (strong, nonatomic) UILabel *last3monthRateLabel;

@end

@implementation UserChatProfileRating

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initiateView];
    }
    return self;
}

- (void)initiateView
{
    
    CGRect frameOfSelf = CGRectMake(0, 0,0, 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
