//
//  ScanDetailedViewController.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/8/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import "ScanDetailedViewController.h"
#import "Products.h"
#import "ProductDetails.h"
#import "CartViewController.h"
#import "ReviewViewController.h"
#import "ViewController.h"

@interface ScanDetailedViewController ()

@end


@implementation ScanDetailedViewController
@synthesize prodName,prodDescription,prodPrice,myImageViewLabel,addToCartButton;
Products *prod;
ProductDetails *prodObject;



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
    prod = [Products sharedInstance];
    prodObject = [prod getProductAtIndex:0];
    
    //Get the details about the product scanned and update labels.
    prodName.text = [NSString stringWithFormat:@"%@",prodObject.productName];
    prodDescription.text = [NSString stringWithFormat:@"%@",prodObject.productDescription];
    prodPrice.text = [NSString stringWithFormat:@"$ %@",prodObject.productPrice];
    myImageViewLabel.image = [ UIImage imageNamed:prodObject.productImage];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}


- (void) viewWillAppear:(BOOL)animated
{
    /*UIBarButoon details*/
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    [prodName reloadInputViews];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Method to add the item to the cart on clicking the button "Add to Cart"
-(IBAction)addToCartButtonTapped:(id)sender
{
    prod = [Products sharedInstance];
    [prod addProductToCart:[[ProductDetails alloc] initWithName: prodObject.productName
                                                 andDescription:prodObject.productDescription
                                                       andPrice:prodObject.productPrice
                                                       andImage:prodObject.productImage
                                                        andLocation:prodObject.productLocation]];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Item is added to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

//Method to go to the review page on Clicking the button "Reviews"

-(IBAction)reviewButtonTapped:(id)sender
{
    UIStoryboard *storyboard = self.storyboard;//creating the detailed view story board
     ReviewViewController *reviewVC = [storyboard
                                          instantiateViewControllerWithIdentifier:@"ReviewVC"];
  
    reviewVC.resultString = resultScanString;
    [self presentViewController:reviewVC animated:YES completion:nil];
    
}

@end

NSString *resultScanString;

