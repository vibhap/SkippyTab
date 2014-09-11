//
//  ViewController.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface ViewController : UIViewController <ZBarReaderDelegate, UITextFieldDelegate>
{
        sqlite3 *database;
        NSMutableArray *arrayOfItems;
}

@property (weak) IBOutlet UITextField *resultTextField;     //to hold the barcode number that is scanned
@property(weak) IBOutlet UIImageView *resultImage;          //holds the scanned image

@property(weak) IBOutlet UIButton *scanButton;
@property(weak) IBOutlet UIButton *infoButton;


-(IBAction)scanButtonTapped:(id)sender;
-(IBAction)infoButtonTapped:(id)sender;



@end

