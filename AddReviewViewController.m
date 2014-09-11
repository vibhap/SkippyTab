//
//  AddReviewViewController.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/9/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//  This view allows the user to add reviews to the product scanned.

#import "AddReviewViewController.h"
#import "ScanDetailedViewController.h"

@interface AddReviewViewController ()
{
     NSString *dbPathString;
}

@end

@implementation AddReviewViewController
@synthesize reviewTextField;

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
   [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"lightWood.png"]]];
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
    
    /*Bar button details*/
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
}

-(IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*make the database copy for the review database*/
-(void) makeDBCopyAsNeeded
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    /*gets the path*/
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"review.db"];
    /*checks if the db already exists*/
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    {
        return;
    }
    
    NSString *defaultDBPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"review.db"];
    
    
    success=[fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if(!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

//Submit the added review on clicking the "Submit" button
-(IBAction)submitButtonPressed:(id)sender
{
    [self makeDBCopyAsNeeded];
    /*alert si displayed when the review text field is empty and the user tries to press the submit button*/
    if([reviewTextField.text isEqual: @""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something went Wrong!!!" message:@"Please type in something" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        char *error;
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [path objectAtIndex:0];
        /*gets the databse path and queries the db if you are able to access it*/
        dbPathString = [docPath stringByAppendingPathComponent:@"review.db"];
        if (sqlite3_open([dbPathString UTF8String], &database) == SQLITE_OK)
        {
        
            NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO REVIEW(barcode,reviews) values ('%@','%s')", resultScanString,[self.reviewTextField.text UTF8String]];
            const char * insertStatement = [insertStmt UTF8String];
            if(sqlite3_exec(database, insertStatement, NULL, NULL, 	&error)==SQLITE_OK)
            {
               // NSLog(@"Review Added");
            }
            sqlite3_close(database);
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Review Added" message:@"Thanks for your feedback!!" delegate:(id)self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }    
}

-(IBAction)returnPressed:(id) sender
{
    [sender resignFirstResponder];
}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

-(IBAction)minimizeKeyboard:(id)sender
{
    [reviewTextField resignFirstResponder];
}

@end

