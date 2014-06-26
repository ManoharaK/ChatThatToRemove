//
//  CellForMyIntersetS.m
//  ChatThat
//
//  Created by Varghese Simon on 5/29/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "CellForMyIntersetS.h"

@interface CellForMyIntersetS ()
@property (weak, nonatomic) IBOutlet UITextField *interestNameLabel;
@property (weak, nonatomic) IBOutlet RateView *rateView;

@end

@implementation CellForMyIntersetS

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initializeCell];
       
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self initializeCell];

}

- (void)initializeCell
{
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"ratingOfIntersetsMyProf@2x.png"];
    self.rateView.editable = NO;
    self.rateView.maxRating = 3;
    self.rateView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRateingOfInterest:(NSInteger)rateingOfInterest
{
    _rateingOfInterest = rateingOfInterest;
    self.rateView.rating = rateingOfInterest;
}

- (void)setInterestName:(NSString *)interestName
{
    _interestName = interestName;
    self.interestNameLabel.text = interestName;
}

- (void)setDelegateOfTextField:(id)delegateOfTextField
{
    _delegateOfTextField = delegateOfTextField;
    self.interestNameLabel.delegate = delegateOfTextField;
}

- (void)setEditable:(BOOL)editable
{
    _editable = editable;
    self.interestNameLabel.userInteractionEnabled = editable;
    if (editable)
    {
        self.interestNameLabel.borderStyle = UITextBorderStyleBezel;
    }else
    {
        self.interestNameLabel.borderStyle = UITextBorderStyleLine;
        self.interestNameLabel.borderStyle = UITextBorderStyleNone;
    }
}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating
{
    
}
@end
