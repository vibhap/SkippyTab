//
//  ProductDetails.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetails : NSObject


@property(nonatomic,strong) NSString *productName;
@property(nonatomic,strong) NSString *productDescription;
@property (nonatomic, strong) NSNumber *productPrice;
@property (nonatomic,strong) NSString *productImage;
@property (nonatomic, strong) NSString *productLocation;

@property (nonatomic,strong) NSString *productReview;

-(id)initWithName:(NSString *)nameOfTheProduct  //designated initializer
   andDescription:(NSString *)productDescription
         andPrice:(NSNumber *)productPrice andImage:(NSString *)image
      andLocation:(NSString *)productLocation;

-(id) initWithReview:(NSString *)productReviews; //designated initializer

@end

