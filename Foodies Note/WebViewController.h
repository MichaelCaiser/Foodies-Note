//
//  WebViewController.h
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/6.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "WriteNoteViewController.h"
#import "YelpListing.h"
@import MapKit;

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)goback:(id)sender;
- (IBAction)WriteNote:(id)sender;
- (IBAction)CheckIn:(id)sender;

@property (strong, nonatomic) NSMutableDictionary* URLArray;
@property(nonatomic,retain)NSString*mobileUrl;

@property (strong, nonatomic) YelpListing *yelpObject;

@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *checkinButton;

@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddress;
@property (weak, nonatomic) IBOutlet UIImageView *rest_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rating_ImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *review_countlabel;

@property (weak, nonatomic) IBOutlet
UIImageView *reviewer;

@property (weak, nonatomic) IBOutlet
UITextView *review;

@end
