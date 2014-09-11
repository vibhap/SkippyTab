//
//  CustomCell.h
//  SkippyTab
//
//  Created by Vibha prahlada and Namratha Bharadwaj on 3/7/14.
//  Copyright (c) 2014 Vibha prahlada and Namratha Bharadwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
/*This class file customizes the table cell*/
@interface CustomCell : UITableViewCell

@property(weak,nonatomic) IBOutlet UILabel *productLabel;
@property(weak,nonatomic) IBOutlet UILabel *productDescLabel;
@property(weak,nonatomic) IBOutlet UIImageView *myImageViewLabel;

@property(weak,nonatomic) IBOutlet UILabel *cartProductLabel;
@property(weak,nonatomic) IBOutlet UILabel *cartPriceLabel;




@end

