//
//  FinalViewController.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/11/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface FinalViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) NSNumber *totalAmount;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *finalAmount;
@property (weak, nonatomic) IBOutlet UITextField *customerCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *customerSecurityKey;
@property (weak, nonatomic) IBOutlet UITextField *customerEmailId;


- (IBAction)finishButtonClicked:(id)sender;

-(void)mailClicked;
-(void)displayComposePage;



@end

