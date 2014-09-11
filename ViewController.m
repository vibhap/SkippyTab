//
//  ViewController.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
// This view controller is the primary view controller that loads as soon as the app is started. It enables the user to scan a barcode image from the photo library and view detailed information about the product selected. It is a simulation of the actual scanning of a product.

#import "ViewController.h"
#import "ScanDetailedViewController.h"
#import "Products.h"
#import "ReviewViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize resultImage,resultTextField;
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
  [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"lightWood.png"]]];
    [super viewDidLoad];
    
    self.resultTextField.delegate = self; //It is used to respond to editing on the resultTextField and indicate that this field is changed.
    for(int i=1; i<=5; i++) {
        NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:[NSString stringWithFormat:@"bar%d",i]ofType:@"png"];
        
        UIImage *imageForTest = [[UIImage alloc] initWithContentsOfFile:filePath];
        
        UIImageWriteToSavedPhotosAlbum(imageForTest,
                                       self,
                                       @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:),
                                       NULL); 
    }

}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo
{
    if (error)
    {
        NSLog(@"\n Error trying to copy image to album");
    } else
    {
        // .... do anything you want here to handle
        // .... when the image has been saved in the photo album
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [resultTextField setHidden:YES];    //This field is hidden in this view controller
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Navigate to the photo library so that the user can select an image when Scan button is clicked.

- (IBAction)scanButtonTapped:(id)sender
{
    
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderController *reader = [ZBarReaderController new];
    reader.readerDelegate = self;
    
    //reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    if ([ZBarReaderController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        reader.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    reader.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:reader animated:YES completion:nil];
    
}

- (IBAction)infoButtonTapped:(id)sender
{
    [self makeDBCopyAsNeeded];
    [self getItems];
    
    /*Alert which pops up when the info button is pressed even before scanning an item*/
    if([resultTextField.text isEqual: @""])
    {
        UIAlertView *noBarCodeAlert = [[UIAlertView alloc] initWithTitle:@"Something went wrong!!!" message:@"Please scan an item" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noBarCodeAlert show];
        
    }
    else
    {
        //Navigate to the ScanDetailedViewController on clicking the "i" button to view details about the scanned product.
        UIStoryboard *storyBoard = self.storyboard;
        ScanDetailedViewController *scannedView = [storyBoard instantiateViewControllerWithIdentifier:@"Scan Detailed View"];
        resultScanString = resultTextField.text;//assigning the data from the text field to this variable
        
        scannedView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:scannedView animated:YES completion:nil];
        resultImage.image = nil; //hiding the image
    }
}


- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    resultTextField.text = symbol.data;
    
    // EXAMPLE: do something useful with the barcode image
    resultImage.image = image;
    //[info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissViewControllerAnimated: YES completion:nil];
}


- (void) dealloc
{
    self.resultImage = nil;
    self.resultTextField = nil;
    //[super dealloc];
}


-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL) shouldAutorotate
{
    return YES;
}

/* making the copy of the item details database*/
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
    prod = [Products sharedInstance];
    arrayOfItems = [[NSMutableArray alloc]init]; //allocating memory for the array
    
    //creates a path for the specified directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    /*gives the path where the item details database is created*/
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"products.db"];
    if (sqlite3_open([path UTF8String], &database)== SQLITE_OK)
    {
        /* It contains the query for the database*/
        NSString *srchStmt = [NSString stringWithFormat:@"select * from items where barcode = '%@'" , resultTextField.text];
        const char *sql = [srchStmt UTF8String];
        sqlite3_stmt *searchStatement;
    
        /*opens the database and checks if there exists a row for the query*/
        if (sqlite3_prepare_v2(database, sql, -1, &searchStatement, NULL)== SQLITE_OK)
        {
            /*gets the data from the required column into the required fields*/
            while (sqlite3_step(searchStatement)== SQLITE_ROW)
            {
                NSString *name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(searchStatement, 1)];
                NSString *itemDescription = [NSString stringWithUTF8String:(char *) sqlite3_column_text(searchStatement, 2)];
                NSNumber *price = [NSNumber numberWithFloat:(float) sqlite3_column_double(searchStatement, 3)];
                NSString *image = [NSString stringWithUTF8String:(char *) sqlite3_column_text(searchStatement, 4)];
                
                NSString *location = [NSString stringWithUTF8String:(char *) sqlite3_column_text(searchStatement, 5)];
                
                /* sets the name, description and price of the item selected*/
                [prod resetArray];
                [prod addProduct:[[ProductDetails alloc] initWithName:name andDescription:itemDescription andPrice:price andImage:image andLocation:location]];
                
            }
        }sqlite3_finalize(searchStatement);
    }
    
}
@end

