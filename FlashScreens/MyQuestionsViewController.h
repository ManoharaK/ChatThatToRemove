//
//  MyQuestionsViewController.h
//  ChatThat
//
//  Created by Varghese Simon on 5/26/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopOverVCProtocol <NSObject>
- (void)popOverVCWithName:(NSString *)name DidSelectedRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface MyQuestionsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic)id<PopOverVCProtocol> delegate;

@end
