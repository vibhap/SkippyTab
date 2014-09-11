//
//  Products.m
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import "Products.h"
#import "ProductDetails.h"

@implementation Products

ProductDetails *productObject;

static Products *sharedInstance;

/*custom initializer to allocate memory for arrays*/
-(id) initCustom
{
    if(self = [super init])
    {
        productArray = [[NSMutableArray alloc]init];
        listArray = [[NSMutableArray alloc]init];
        cartArray = [[NSMutableArray alloc]init];
        reviewArray = [[NSMutableArray alloc]init];
    }
    return self;
}


/*class method to access the instance*/
+(Products *) sharedInstance
{
    if(!sharedInstance)
    {
        sharedInstance = [[Products alloc] initCustom];
    }
    return sharedInstance;
}


/*adding the products to the array*/
-(void) addProduct:(ProductDetails *) addProduct
{
    [productArray addObject:addProduct];
}

/*adding all the products in the store to the array*/
-(void) addProductToList:(ProductDetails *) addProductToList
{
    [listArray addObject:addProductToList];
}

/*adding the items to the cart*/
-(void) addProductToCart:(ProductDetails *) addProductToCart
{
    [cartArray addObject:addProductToCart];
}

/*adding review to the array*/
-(void) addReviewToArray:(ProductDetails *) addReviewToArray
{
    [reviewArray addObject:addReviewToArray];
}

/*returns the total number of elements in this array*/
-(int) totalNumberOfProducts
{
     return [productArray count];
}

/*returns the total number of elements in the list array*/
-(int) totalNumberOfProductsToList
{
    return [listArray count];
}

/*returns the total number of elements in the cart array*/
-(int) totalNumberOfProductsInCart
{
    return [cartArray count];
}

/*returns the total number of elements in the review array*/
-(int) totalNumberOfReviews
{
    return [reviewArray count];
}


/*returns the object at the specified index*/
-(ProductDetails *)getProductAtIndex :(NSInteger) index
{
    return [productArray objectAtIndex: index ];
    
}

/*returns the object at the specified index*/
-(ProductDetails *)getProductListAtIndex :(NSInteger) index
{
    return [listArray objectAtIndex: index ];
    
}

/*returns the object at the specified index*/
-(ProductDetails *)getProductAtCart :(NSInteger) index
{
    return [cartArray objectAtIndex: index ];
    
}

/*returns the object at the specified index*/
-(ProductDetails *)getReviewAtIndex :(NSInteger) index
{
    return [reviewArray objectAtIndex: index ];
}

/*deleting the elements in this array*/
-(void)resetArray
{
    [productArray removeAllObjects];
}

/*deleting the elements in this array*/
-(void)resetReviewArray
{
    [reviewArray removeAllObjects];
}

/*deleting the elements at the specified index*/
-(void) removeEntry : (NSInteger) index
{
    [cartArray removeObjectAtIndex:index];
}

/*deleting the elements in this array*/
-(void)resetCartArray
{
    [cartArray removeAllObjects];
}

/*calcualtes the total amount to be paid*/
-(float) totalPriceOfCart
{
    double priceOfCart = 0.0;
    float newValue;
    
    for(ProductDetails *eachProduct in cartArray)
    {
        newValue = [eachProduct.productPrice floatValue];
        priceOfCart = priceOfCart + newValue;
    }
    return priceOfCart;
    
}

/*prints the cart items*/
-(NSString *)printCartItems
{
    NSString *cartItems;
    cartItems = [NSString stringWithFormat:@
                 "Receipt\n\n"];
    
    for(ProductDetails *eachCartProduct in cartArray)
    {
        cartItems = [NSString stringWithFormat:@"%@%@: $ %@\n",cartItems, eachCartProduct.productName, eachCartProduct.productPrice];
    }
    return cartItems;
}


@end

Products *products;

