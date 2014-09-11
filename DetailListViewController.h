//
//  DetailListViewController.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetails.h"

@interface DetailListViewController : UIViewController

@property (strong, atomic)  ProductDetails *prodObject;

@property (weak,nonatomic) IBOutlet UILabel *prodName;
@property (weak,nonatomic) IBOutlet UILabel *prodDescription;
@property (weak,nonatomic) IBOutlet UILabel *prodPrice;
@property (weak,nonatomic)IBOutlet UILabel *prodlocation;
@property (weak,nonatomic) IBOutlet UIImageView *myImageViewLabel;


@end

