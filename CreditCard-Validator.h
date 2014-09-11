//
//  CreditCard-Validator.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/11/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//This is an interface for credit card validator. We used it from a third party application which in turn uses the luhn algorithm to validate the credit card numbers.

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CreditCardBrand)
{
    CreditCardBrandVisa,
    CreditCardBrandMasterCard,
    CreditCardBrandDinersClub,
    CreditCardBrandAmex,
    CreditCardBrandDiscover,
    CreditCardBrandUnknown
};


@interface CreditCard_Validator : NSObject


+ (CreditCardBrand)checkCardBrandWithNumber:(NSString *)cardNumber;
+ (BOOL)checkCreditCardNumber:(NSString *)cardNum;

@end

