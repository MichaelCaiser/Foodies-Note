//
//  WebViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/6.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//


//The class for the page to show the detail of the restaurant
// it will show the info of the restaurant, a review of other person, and its location on the map
//what's more, you can check in the restaurant, then the rest will show in the me page.

#import "WebViewController.h"
#import "AsyncImageView.h"


@interface WebViewController ()

@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    //set the url
    NSURL *HYHAppsURL = [NSURL URLWithString:self.yelpObject.url];
                         
                         NSURLRequest *Request = [NSURLRequest requestWithURL:HYHAppsURL];
                         
                         [self.webview loadRequest:Request];
    //set the navigationbar
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //set the location
    self.latitude = [self.yelpObject.coordinate valueForKey:@"latitude"];
    self.longitude = [self.yelpObject.coordinate valueForKey:@"longitude"];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);
    annotation.title = self.yelpObject.name;
    annotation.subtitle = self.yelpObject.address;
    [self.mapView addAnnotation:annotation];
    //set the mapview ofthe rest location
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [self.latitude floatValue];
    region.center.longitude = [self.longitude floatValue];
    region.span.longitudeDelta = 0.015f;
    region.span.longitudeDelta = 0.015f;
    [self.mapView setRegion:region animated:YES];
    [self.mapView setCenterCoordinate:region.center animated:YES];
    
    self.restaurantName.text=self.yelpObject.name;
    NSString *add = [self.yelpObject.display_address description];
    NSString *newAdd = [add substringFromIndex:2];
    self.restaurantAddress.text=newAdd;
    if(self.yelpObject.image_url)
        self.rest_ImageView.imageURL=[NSURL URLWithString:self.yelpObject.image_url];
    self.rating_ImageView.imageURL=[NSURL URLWithString:self.yelpObject.rating_img_url_large];
    self.phoneLabel.text=[NSString stringWithFormat:@"Ph: %@",self.yelpObject.display_phone];
    //self.review_countlabel.text=[NSString stringWithFormat:@"Reviewed by %@users",rmodel.review_count];
    self.reviewer.imageURL =[NSURL URLWithString:self.yelpObject.snippet_image_url];
    self.review.text = self.yelpObject.snippet_text;
    
    //check if it already in the check in list
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"checkin.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    NSArray * articleArray = (NSArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray * tmp = nil;
    if (articleArray) {
        tmp = [[NSMutableArray alloc] initWithArray:articleArray];
    } else {
        tmp = [[NSMutableArray alloc] init];
    }
    
    for (YelpListing * yelp in tmp) {
        if ([self.yelpObject.name isEqualToString:yelp.name]) {
            [self.checkinButton setTitle:@"You have checked in!" forState:UIControlStateNormal]; // To set the title
            [self.checkinButton setEnabled:NO];
        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//go back to dicover page
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//go to write not page
- (IBAction)WriteNote:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WriteNoteViewController* writeNoteController = [storyboard instantiateViewControllerWithIdentifier:@"WriteNote"];
    
    YelpListing *ym= self.yelpObject;
    writeNoteController.yelpObject=ym;

    [self.navigationController pushViewController:writeNoteController animated:YES];
    
}

//after checkin, the restaurant will be added into checkin list that used to show in me page
- (IBAction)CheckIn:(id)sender {
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"checkin.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    NSArray * articleArray = (NSArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray * tmp = nil;
    if (articleArray) {
        tmp = [[NSMutableArray alloc] initWithArray:articleArray];
    } else {
        tmp = [[NSMutableArray alloc] init];
    }
    
    [tmp addObject:self.yelpObject];
    NSData * checkin = [NSKeyedArchiver archivedDataWithRootObject:tmp];
    [checkin writeToURL:file atomically:NO];
    
    [self.checkinButton setTitle:@"You have checked in!" forState:UIControlStateNormal]; // To set the title
    [self.checkinButton setEnabled:NO];
    
}

//initial the nib
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
@end
