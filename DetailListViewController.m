//
//  DetailListViewController.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
// This view controller displays details about the product corresponding to the table view cell that was selected by the user.

#import "DetailListViewController.h"
#import "Products.h"

@interface DetailListViewController ()

@end

@implementation DetailListViewController
@synthesize prodName,prodDescription,prodPrice,prodObject,myImageViewLabel,prodlocation;
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
    //Get product details and update the corresponding labels
    prodName.text = [NSString stringWithFormat:@"%@",prodObject.productName];
    prodDescription.text = [NSString stringWithFormat:@"%@",prodObject.productDescription];
    prodPrice.text = [NSString stringWithFormat:@"$ %@",prodObject.productPrice];
    prodlocation.text = [NSString stringWithFormat:@"This item can be found in %@",prodObject.productLocation];
    myImageViewLabel.image = [ UIImage imageNamed:prodObject.productImage];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

