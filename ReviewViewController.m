//
//  ReviewViewController.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import "ReviewViewController.h"
#import "Products.h"
#import "ProductDetails.h"
#import "AddReviewViewController.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController
@synthesize resultString,anotherTableView;

Products *prod;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewWillAppear:(BOOL)animated
{
    /*back button code in the navigation bar*/
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    /*Right button in the navigation bar*/
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addReview)];
    
    [prod resetReviewArray];        //deleting the elements of this array
    [self makeDBCopyAsNeeded];
    [self getItems];
    
    [anotherTableView reloadData];

}
/*dismisses the view controller when the back button is pressed*/
-(IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*A  story board to add review is created when the add review button is pressed*/
-(IBAction)addReview
{
    UIStoryboard *storyboard = self.storyboard;//creating the detailed view story board
    AddReviewViewController *addReviewVC = [storyboard
                                            instantiateViewControllerWithIdentifier:@"AddReviewVC"];
    
    [self presentViewController:addReviewVC animated:YES completion:nil];    

}

-(void) makeDBCopyAsNeeded
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    /* Creating the required path */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    /*gives the path where the item details database is created*/
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"review.db"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    {
        return;
    }
     /*creates and initializes a bundle object if one didn't exist*/
    NSString *defaultDBPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"review.db"];
    
    
    success=[fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if(!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

/*Retrive data from the database*/
-(void) getItems
{
    prod = [Products sharedInstance];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);

    NSString *documentsDirectory = [paths objectAtIndex:0];
    //specifies the path and creates the .db file in this path
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"review.db"];
    if (sqlite3_open([path UTF8String], &database)== SQLITE_OK)
    {
        /* It contains the query for the database*/
        NSString *srchStmt = [NSString stringWithFormat:@"select * from review where barcode = '%@'", resultString];
    
        const char *sql = [srchStmt UTF8String];
        sqlite3_stmt *searchStatement;
    
        /*opens the database and checks if there exists a row for the query*/
        if (sqlite3_prepare_v2(database, sql, -1, &searchStatement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(searchStatement)== SQLITE_ROW)
            {
                NSString *name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(searchStatement, 1)];
                [prod addReviewToArray:[[ProductDetails alloc]initWithReview:name]];
            }
        }sqlite3_finalize(searchStatement);
    }
}

/*Datasource methods*/
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    prod = [Products sharedInstance];
    return [prod totalNumberOfReviews];
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   prod = [Products sharedInstance];
    NSString *cellID = @"defaultCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (! cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    ProductDetails *prodObject = [prod getReviewAtIndex:[indexPath row]];
    //displays the reviews
    cell.textLabel.text = [NSString stringWithFormat:@"%@", prodObject.productReview];
    return cell;    
}

@end

