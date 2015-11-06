//
//  YelpListing.m
//  GebeChat
//
//  Created by Siba Prasad Hota on 12/01/15.
//  Copyright (c) 2015 WemakeAppz. All rights reserved.
//

//3rd part code modifed by us by using NSCoder
#import "YelpListing.h"

@implementation YelpListing

- (id) initWithCoder:(NSCoder *) decoder{
    self=[super init];
    self.status = [decoder decodeObjectForKey:@"status"];
    self.status_Msg = [decoder decodeObjectForKey:@"status_Msg"];
    self.status_code = [decoder decodeObjectForKey:@"status_code"];
    self.restaurant_id = [decoder decodeObjectForKey:@"restaurant_id"];
    self.is_claimed = [decoder decodeObjectForKey:@"is_claimed"];
    self.is_closed = [decoder decodeObjectForKey:@"is_closed"];
    self.city = [decoder decodeObjectForKey:@"city"];
    self.address = [decoder decodeObjectForKey:@"address"];
    self.coordinate = [decoder decodeObjectForKey:@"coordinate"];
    self.country_code = [decoder decodeObjectForKey:@"country_code"];
    self.display_address = [decoder decodeObjectForKey:@"display_address"];
    self.geo_accuracy = [decoder decodeObjectForKey:@"geo_accuracy"];
    self.neighborhoods = [decoder decodeObjectForKey:@"neighborhoods"];
    self.state_code = [decoder decodeObjectForKey:@"state_code"];
    self.mobile_url = [decoder decodeObjectForKey:@"mobile_url"];
    self.name = [decoder decodeObjectForKey:@"name"];
    self.rating = [decoder decodeObjectForKey:@"rating"];
    self.rating_img_url = [decoder decodeObjectForKey:@"rating_img_url"];
    self.rating_img_url_large = [decoder decodeObjectForKey:@"rating_img_url_large"];
    self.rating_img_url_small = [decoder decodeObjectForKey:@"rating_img_url_small"];
    self.url = [decoder decodeObjectForKey:@"url"];
    self.review_count = [decoder decodeObjectForKey:@"review_count"];
    self.display_phone = [decoder decodeObjectForKey:@"display_phone"];
    self.image_url = [decoder decodeObjectForKey:@"image_url"];
    self.phone = [decoder decodeObjectForKey:@"phone"];
    self.snippet_text = [decoder decodeObjectForKey:@"snippet_text"];
    self.snippet_image_url = [decoder decodeObjectForKey:@"snippet_image_url"];
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.status forKey:@"status"];
    [encoder encodeObject:self.status_Msg forKey:@"status_Msg"];
    [encoder encodeObject:self.status_code forKey:@"status_code"];
    [encoder encodeObject:self.restaurant_id forKey:@"restaurant_id"];
    [encoder encodeObject:self.is_claimed forKey:@"is_claimed"];
    [encoder encodeObject:self.is_closed forKey:@"is_closed"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.coordinate forKey:@"coordinate"];
    [encoder encodeObject:self.country_code forKey:@"country_code"];
    [encoder encodeObject:self.display_address forKey:@"display_address"];
    [encoder encodeObject:self.geo_accuracy forKey:@"geo_accuracy"];
    [encoder encodeObject:self.neighborhoods forKey:@"neighborhoods"];
    [encoder encodeObject:self.state_code forKey:@"state_code"];
    [encoder encodeObject:self.mobile_url forKey:@"mobile_url"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.rating forKey:@"rating"];
    [encoder encodeObject:self.rating_img_url forKey:@"rating_img_url"];
    [encoder encodeObject:self.rating_img_url_large forKey:@"rating_img_url_large"];
    [encoder encodeObject:self.rating_img_url_small forKey:@"rating_img_url_small"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.review_count forKey:@"review_count"];
    [encoder encodeObject:self.display_phone forKey:@"display_phone"];
    [encoder encodeObject:self.image_url forKey:@"image_url"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.snippet_text forKey:@"snippet_text"];
    [encoder encodeObject:self.snippet_image_url forKey:@"snippet_image_url"];
    
}


@end
