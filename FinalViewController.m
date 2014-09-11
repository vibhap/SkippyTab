//
//  FinalViewController.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/11/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.

//  This view calculates the total cart amount. It also imports CreditCard-Validator.h to use the methods defined to validate the card number. It is the final view that accepts the customer's card number along with their mail id to bill for the items purchased. On clicking "Finish" it takes the user to another view where in the user can mail themselves the receipt for their purchase.

#import "FinalViewController.h"
#import "Products.h"
#import "CreditCard-Validator.h"
#import "CartViewController.h"

@interface FinalViewController ()

@end

@implementation FinalViewController
@synthesize totalAmount, finalAmount, customerCardNumber, customerEmailId, customerSecurityKey;

Products *prod;

NSString *cardNumber, *securityKey, *emailId;

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
    [self.scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"lightWood.png"]]];
    
    //Calculate the total amount of the cart
    prod = [Products sharedInstance];
    cartTotalAmount = [prod totalPriceOfCart];
    
    totalAmount = [NSNumber numberWithFloat:cartTotalAmount];
    //Update label
    finalAmount.text = [NSString stringWithFormat:@"$ %@",totalAmount];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:(CGSizeMake(320, 800))];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:gesture];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(void)hideKeyBoard
{
    [customerCardNumber resignFirstResponder];
    [customerSecurityKey resignFirstResponder];
    [customerEmailId resignFirstResponder];
}


- (void) viewWillAppear:(BOOL)animated
{
    
    prod = [Products sharedInstance];
    cartTotalAmount = [prod totalPriceOfCart];
    
    totalAmount = [NSNumber numberWithFloat:cartTotalAmount];
    finalAmount.text = [NSString stringWithFormat:@"$ %@",totalAmount];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:(CGSizeMake(320, 800))];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Validate credit card and if everything is good, go to mail view controller
- (IBAction)finishButtonClicked:(id)sender
{
    prod = [Products sharedInstance];
    emailId = [self.customerEmailId text];
    cardNumber = [self.customerCardNumber text];
    securityKey = [self.customerSecurityKey text];
    
        
    if([securityKey length] == 0 || [emailId length] == 0)
    {
        UIAlertView *missingFields = [[UIAlertView alloc]initWithTitle:@"One or more Fields Missing" message:@"Please fill in all the fileds" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [missingFields show];
    }
    else
    {
        [CreditCard_Validator checkCardBrandWithNumber:cardNumber];
        BOOL isValid;
        isValid = [CreditCard_Validator checkCreditCardNumber:cardNumber];
        
        if(isValid == NO || [cardNumber length] == 0)
        {
            UIAlertView *invalidCardAlert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Invalid Card Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [invalidCardAlert show];
        }
        else
        {
            UIAlertView *validCardAlert = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"Payment Successful!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [validCardAlert show];
            
            [customerCardNumber setText:@""];
            [customerEmailId setText:@""];
            [customerSecurityKey setText:@""];
            [finalAmount setText:@"Amount"];
            
            [self mailClicked];
            
            [prod resetCartArray];
            
        }
    }
    
}

//Methods adhering to the protocol <MFMailComposeViewControllerDelegate>
-(void)mailClicked
{
    Class emailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if(emailClass!=nil)
    {
        if([emailClass canSendMail])
        {
            [self displayComposePage];
        }
        else
        {
            UIAlertView *emailAlert = [[UIAlertView alloc]initWithTitle:@"Email can't be sent" message:@"Device not configured to send mail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [emailAlert show];
        }        
        
    }
    else
    {
        UIAlertView *emailAlert1 = [[UIAlertView alloc]initWithTitle:@"Email can't be sent" message:@"Device cannot send an email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [emailAlert1 show];
        
    }
}

//Prepare the mail compose page.
-(void)displayComposePage
{
    
    prod = [Products sharedInstance];
    MFMailComposeViewController *composePage = [[MFMailComposeViewController alloc]init];
    composePage.mailComposeDelegate = self;
    NSArray *recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",emailId]];
    [composePage setToRecipients:recipients];
    [composePage setSubject:@"Skippy Receipt"];
    [composePage setMessageBody:[prod printCartItems] isHTML:NO];
    [composePage setTitle:@"Email"];
    composePage.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:composePage animated:YES completion:nil];
    
}

//Dismiss view controller on clicking send/cancel
-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    UIAlertView *successAlert = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"Thank you for shopping with us" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [successAlert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

