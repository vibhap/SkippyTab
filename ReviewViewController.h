//
//  ReviewViewController.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ReviewViewController : UIViewController<UITableViewDataSource>
{
    sqlite3 *database;
   
}

@property (weak, nonatomic) IBOutlet UITableView *anotherTableView;
@property (weak, nonatomic)NSString *resultString;  //holds the barcode value from the first view


-(IBAction)back;
-(IBAction)addReview;

-(void) getItems;
-(void) makeDBCopyAsNeeded;


@end

