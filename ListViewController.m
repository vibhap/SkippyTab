//
//  ListViewController.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import "ListViewController.h"
#import "DetailListViewController.h"
#import "Products.h"
#import "CustomCell.h"

@interface ListViewController ()

@end

@implementation ListViewController

Products *prod;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
      
    }
    return self;
}

- (void)viewDidLoad
{
    /*Sets the background image*/
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"lightWood.png"]]];
    
    [super viewDidLoad];
    
    [self makeDBCopyAsNeeded];
    [self getItems];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"products.db"];
    
    /*gives a boolean value based on whether the file existed at that path*/
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    {
        return;
    }
    /*creates and initializes a bundle object if one didn't exist*/
    NSString *defaultDBPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"products.db"];
    
    success=[fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if(!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

/*Retrives the data from the database*/
-(void) getItems
{
    prod = [Products sharedInstance];   //getting the shared instance
    arrayOfItems = [[NSMutableArray alloc]init]; //allocating memory for the array
    
    //creates a path for the specified directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //specifies the path and creates the .db file in this path
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"products.db"];
    
    if (sqlite3_open([path UTF8String], &database)== SQLITE_OK)
    {
        /* It contains the query for the database*/
        NSString *srchStmt = [NSString stringWithFormat:@"select * from items"];
        const char *sql = [srchStmt UTF8String];
        sqlite3_stmt *searchStatement;
        /*opens the database and checks if there exists a row for the query*/
        if (sqlite3_prepare_v2(database, sql, -1, &searchStatement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(searchStatement)== SQLITE_ROW)
            {
                NSString *name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(searchStatement, 1)];
                NSString *itemDescription = [NSString stringWithUTF8String:(char *) sqlite3_column_text(searchStatement, 2)];
                NSNumber *price = [NSNumber numberWithFloat:(float) sqlite3_column_double(searchStatement, 3)];
                NSString *image = [NSString stringWithUTF8String:(char *) sqlite3_column_text(searchStatement, 4)];
                
                NSString *location=[NSString stringWithUTF8String:(char *) sqlite3_column_text(searchStatement, 5)];
                
                /* sets the name, description and price of the item selected*/
                [prod addProductToList:[[ProductDetails alloc] initWithName:name andDescription:itemDescription andPrice:price andImage:image andLocation:location]];
            }
        }sqlite3_finalize(searchStatement);
    }
    
}

/*UITableViewDataSource methods*/
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     prod = [Products sharedInstance];
     return [prod totalNumberOfProductsToList];
 }


 -(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     prod = [Products sharedInstance];
     
     static NSString *CellIdentifier = @"Cell";
     CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (! cell)
     {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     }
 
     ProductDetails *prodObject = [prod getProductListAtIndex:[indexPath row]];
     /* sets the labels at the table view cell*/
     cell.productLabel.text = [NSString stringWithFormat:@"%@", prodObject.productName];
     cell.productDescLabel.text = [NSString stringWithFormat:@"%@", prodObject.productDescription];
     cell.myImageViewLabel.image = [ UIImage imageNamed:prodObject.productImage];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     return cell;
 }

/*UITableViewDelegate*/
 -(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
    UIStoryboard *storyboard = self.storyboard;//creating the detailed view story board
     DetailListViewController *detailedVC = [storyboard  instantiateViewControllerWithIdentifier:@"DetailedVC"];
     
    prod = [Products sharedInstance];
    detailedVC.prodObject = [prod getProductListAtIndex:indexPath.row];//pushes the object at that index to the detailedVC when that row is selected.
     detailedVC.title = detailedVC.prodObject.productName;
    [self.navigationController pushViewController: detailedVC animated:YES];
 
 }



@end

