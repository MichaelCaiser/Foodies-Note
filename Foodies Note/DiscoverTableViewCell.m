//
//  DiscoverTableViewCell.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/2/27.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

//the class for the restaurant cell to set cell data
//using by headertableviewcell

#import "DiscoverTableViewCell.h"
#import "YelpListing.h"
#import "AsyncImageView.h"

@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//set the date of the rest cell
//using the data of the api(yelp)
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
