//
//  YelpListing.h
//  GebeChat
//
//  Created by Siba Prasad Hota on 12/01/15.
//  Copyright (c) 2015 WemakeAppz. All rights reserved.
//

//3rd part code modified by us by using NSCoder
#import <Foundation/Foundation.h>

@interface YelpListing : NSObject <NSCoding>

@property(nonatomic,strong)  NSString *status;
@property(nonatomic,strong)  NSString *status_Msg;
@property(nonatomic,strong)  NSString *status_code;

@property(nonatomic,strong) NSString *restaurant_id;
@property(nonatomic,strong) NSString *is_claimed;
@property(nonatomic,strong) NSString *is_closed;
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *coordinate;
@property(nonatomic,strong) NSString *country_code;
@property(nonatomic,strong) NSString *display_address;
@property(nonatomic,strong) NSString *geo_accuracy;
@property(nonatomic,strong) NSString *neighborhoods;
@property(nonatomic,strong) NSString *state_code;
@property(nonatomic,strong) NSString *mobile_url;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *rating;

@property(nonatomic,strong) NSString *rating_img_url;
@property(nonatomic,strong) NSString *rating_img_url_large;
@property(nonatomic,strong) NSString *rating_img_url_small;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *review_count;
@property(nonatomic,strong) NSString *display_phone;
@property(nonatomic,strong) NSString *image_url;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *snippet_text;
@property(nonatomic,strong) NSString *snippet_image_url;

@end

