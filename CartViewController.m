//
//  CartViewController.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import "CartViewController.h"
#import "ProductDetails.h"
#import "Products.h"
#import "CustomCell.h"
#import "FinalViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController

@synthesize anotherTableView;

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
    
    //setting the border properties for the table view
    anotherTableView.layer.borderWidth = 2.0;
    anotherTableView.layer.borderColor = [UIColor blackColor].CGColor;
    anotherTableView.layer.cornerRadius = 10;
    
}


- (void) viewWillAppear:(BOOL)animated
{
    //refreshing the table view when the view appears
    [anotherTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    prod = [Products sharedInstance];
    return [prod totalNumberOfProductsInCart];
}

/*datasource methods*/
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    prod = [Products sharedInstance];
    static NSString *CellIdentifier = @"CartCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell)
    {
         cell = [[CustomCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     ProductDetails *prodObject = [prod getProductAtCart:[indexPath row]];
   
     cell.cartProductLabel.text = [NSString stringWithFormat:@"%@", prodObject.productName];
     cell.cartPriceLabel.text=[NSString stringWithFormat:@" $ %@", prodObject.productPrice];
     return cell;
}

/*to delete the rows from the table*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


/*setting the editing functionality to table view*/
-(void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [anotherTableView setEditing:editing animated:animated];
    
}

/* deleting the row from the cart table view*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    prod = [Products sharedInstance];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [prod removeEntry:indexPath.row];        
        [anotherTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end

double cartTotalAmount;

