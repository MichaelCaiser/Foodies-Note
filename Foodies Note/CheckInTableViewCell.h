//
//  CheckInTableViewCell.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpListing.h"

@interface CheckInTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddress;
@property (weak, nonatomic) IBOutlet UIImageView *rest_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rating_ImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *review_countlabel;

-(void)setCellData:(YelpListing*)rmodel;

@end
