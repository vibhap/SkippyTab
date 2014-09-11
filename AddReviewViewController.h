//
//  AddReviewViewController.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/9/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface AddReviewViewController : UIViewController
{
    sqlite3 *database;
}

@property (weak) IBOutlet UITextField *reviewTextField;


-(IBAction)submitButtonPressed:(id)sender;
-(IBAction)returnPressed:(id) sender;
-(IBAction)back;
-(IBAction)minimizeKeyboard:(id)sender;

@end

