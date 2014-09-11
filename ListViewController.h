//
//  ListViewController.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ProductDetails.h"

@interface ListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    sqlite3 *database;
    NSMutableArray *arrayOfItems;
}

-(void) makeDBCopyAsNeeded;
-(void) getItems;

@end

