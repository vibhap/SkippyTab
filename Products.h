//
//  Products.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetails.h"

@interface Products : NSObject 
{
    NSMutableArray *productArray;   //stores the product details
    NSMutableArray *listArray;      //stores the list of the store products
    NSMutableArray *cartArray;      //stores the elements added to the cart
    NSMutableArray *reviewArray;    //stores the reviews of each product
}

-(NSString *)printCartItems;

+(Products *) sharedInstance;

-(ProductDetails *)getProductAtIndex :(int) index;
-(ProductDetails *)getProductAtCart :(NSInteger) index;
-(ProductDetails *)getProductListAtIndex :(NSInteger) index;
-(ProductDetails *)getReviewAtIndex :(NSInteger) index;

-(void) addProduct:(ProductDetails *) addProduct;
-(void) addProductToList:(ProductDetails *) addProductToList;
-(void) addProductToCart:(ProductDetails *) addProductToCart;
-(int) totalNumberOfProducts;
-(int) totalNumberOfProductsToList;
-(int) totalNumberOfProductsInCart;
-(int) totalNumberOfReviews;
-(void) addReviewToArray:(ProductDetails *) addReviewToArray;
-(void)resetArray;
-(void)resetReviewArray;
-(void)resetCartArray;
-(void) removeEntry : (NSInteger) index;
-(float) totalPriceOfCart;

@end

extern Products *products;
