//
//  ProductDetails.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import "ProductDetails.h"

@implementation ProductDetails

@synthesize productName,productDescription,productPrice,productImage,productReview,productLocation;

/*setting the initial value*/
-(id)init
{
    self = [super init];
    if(self)
    {
        productName = @"";
        productDescription=@"";
        productPrice = 0;
        productImage = @"";
        productReview = @"";
        productLocation = @"";
        
    }
    return self;
}


/*sets the name,description,price,image and location of the product*/
-(id)initWithName:(NSString *)nameOfTheProduct andDescription:(NSString *)productDesc
         andPrice:(NSNumber *)price andImage:(NSString *)image andLocation:(NSString *)loc
{
    self = [super init];
    if(self)
    {
        productName = nameOfTheProduct;
        productDescription=productDesc;
        productPrice = price;
        productImage = image;
        productLocation = loc;
        
        
    }
    return self;

}

/*sets the product review*/
-(id) initWithReview:(NSString *)productReviews
{
    self = [super init];
    if(self)
    {
        productReview = productReviews;
    }
    return self;
}

@end

