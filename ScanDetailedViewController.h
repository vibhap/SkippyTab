//
//  ScanDetailedViewController.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/8/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <QuartzCore/QuartzCore.h>
#import "Products.h"

@interface ScanDetailedViewController : UIViewController

@property (weak) IBOutlet UILabel *prodName;
@property (weak) IBOutlet UILabel *prodDescription;
@property (weak) IBOutlet UILabel *prodPrice;
@property(weak) IBOutlet UIButton *addToCartButton;
@property(weak) IBOutlet UIImageView *myImageViewLabel;

-(IBAction)addToCartButtonTapped:(id)sender;
-(IBAction)reviewButtonTapped:(id)sender;

extern NSString *resultScanString;

@end

