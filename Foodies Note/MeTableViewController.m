//
//  MeTableViewController.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

//the class for the 3rd tab page: me;
// here will show the info of the user
// and all the rest that you have check in
// the level means the number of rest you checked in

#import "MeTableViewController.h"
#import "YelpListing.h"
#import "PersonalCheckInTableViewCell.h"
#import "CheckInTableViewCell.h"
#import "MapCheckInTableViewCell.h"
#import "WebViewController.h"

@interface MeTableViewController () <FBLoginViewDelegate>

@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set the navigation bar and items
    self.title = @"Me";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    UIBarButtonItem *shareFB = [[UIBarButtonItem alloc]
                                initWithTitle:@" "
                                style:UIBarButtonItemStylePlain
                                target:self
                                action:@selector(shareInFB)];
    self.navigationItem.rightBarButtonItem = shareFB;
    shareFB.image = [UIImage imageNamed:@"facebook.png"];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewWillAppear:(BOOL)animated{
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"checkin.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    self.checkinItems = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.tableView reloadData];
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    
    self.checkinNum = [NSString stringWithFormat:@"Aleady checked in %lu places!", (unsigned long)self.checkinItems.count];
    
    /*
     assign level
     */
    
    self.level = [NSString stringWithFormat:@"Level: %lu", (unsigned long)self.checkinItems.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.checkinItems.count+2;
}

//info cell, map cell and other rest cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowNo = indexPath.row;
    if(rowNo==0){
        static NSString *CellIdentifier = @"PersonalCheckInCell";
        PersonalCheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (FBSession.activeSession.isOpen) {
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection,
               NSDictionary<FBGraphUser> *user,
               NSError *error) {
                 if (!error) {
                     cell.name.text = user.name;
                     cell.FBPicture.profileID = user.objectID;
                     NSLog(@"justtry=%@",user.name);
                 }
             }];
        }
        
        cell.level.text = self.level;
        cell.checkinNum.text = self.checkinNum;
        FBLoginView *loginView = [[FBLoginView alloc] init];
        loginView.delegate = cell;
        return cell;
        
    }
    if(rowNo==1){
        static NSString *CellIdentifier = @"MapCheckinCell";
        MapCheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.profilePicture = self.profilePicture;
        //cell.name.text = self.name;
        NSLog(@"HEIWEGOU");
        //[cell refreshMap];
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
        
        NSLog(@"countnum=%ld",tmp.count);
        
        for (YelpListing * yelp in tmp) {
            NSLog(@"not here??");
            NSString *latitude = [yelp.coordinate valueForKey:@"latitude"];
            NSString *longitude = [yelp.coordinate valueForKey:@"longitude"];
            
            NSLog(@"location=%@",latitude);
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
            annotation.title = yelp.name;
            annotation.subtitle = yelp.display_phone;
            [cell.mapView addAnnotation:annotation];
            
            MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
            region.center.latitude = [latitude floatValue];
            region.center.longitude = [longitude floatValue];
            region.span.longitudeDelta = 1.8f;
            region.span.longitudeDelta = 1.8f;
            [cell.mapView setRegion:region animated:YES];
            [cell.mapView setCenterCoordinate:region.center animated:YES];
        }
        return cell;
        
    }
    
    
    static NSString *CellIdentifier = @"CheckInCell";
    
    
    CheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    YelpListing *object = self.checkinItems[indexPath.row-2];
    
    [cell setCellData:object];
    
    return cell;

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePicture.profileID = user.objectID;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //goto web page (detail of the rest) if tapped
    if(indexPath.row != 1 ||indexPath.row != 0){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebViewController* webViewController = [storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
        
        YelpListing *ym=[self.checkinItems objectAtIndex:indexPath.row-2];
        webViewController.yelpObject=ym;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rows in section 0 should not be selectable
    
    // first 3 rows in any section should not be selectable
    if ( indexPath.row <= 1 ) return nil;
    
    // By default, allow row to be selected
    return indexPath;
}

//share in fb
- (void) shareInFB {
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:nil
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User canceled.
                                                          NSLog(@"User cancelled.");
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User canceled.
                                                              NSLog(@"User cancelled.");
                                                              
                                                          } else {
                                                              // User clicked the Share button
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
    
}

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

@end
