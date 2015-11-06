//
//  DiscoverTableViewController.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/2/27.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>
#import "MapTableViewCell.h"

@class WebViewController;

@interface DiscoverTableViewController : UITableViewController<NSFetchedResultsControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTerm;
- (IBAction)search:(id)sender;

-(void)getRestaurantsByTerm:(NSString*)term islonglat:(BOOL)islonglat;

@property (strong, nonatomic) WebViewController *detailViewController;
@property (strong, nonatomic) NSDictionary *issue;

@property float latitude;
@property float longitude;

@property (strong, nonatomic) NSString *restname;
@property (strong, nonatomic) NSURL * resturl;

@property (strong, nonatomic) CLLocationManager *locationManager;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;

@end
