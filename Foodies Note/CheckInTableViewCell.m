//
//  CheckInTableViewCell.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

// Cell uses properties to display users checked in restaurant information 

#import "CheckInTableViewCell.h"
#import "YelpListing.h"
#import "AsyncImageView.h"

@implementation CheckInTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(YelpListing*)rmodel
{
    self.restaurantName.text=rmodel.name;
    NSString *add = [rmodel.display_address description];
    NSString *newAdd = [add substringFromIndex:2];
    self.restaurantAddress.text=newAdd;
    if(rmodel.image_url)
        self.rest_ImageView.imageURL=[NSURL URLWithString:rmodel.image_url];
    self.rating_ImageView.imageURL=[NSURL URLWithString:rmodel.rating_img_url_large];
    self.phoneLabel.text=[NSString stringWithFormat:@"Ph: %@",rmodel.display_phone];
    self.review_countlabel.text=[NSString stringWithFormat:@"Reviewed by %@users",rmodel.review_count];
    //review_count
}

@end
