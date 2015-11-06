//
//  DiscoverTableViewController.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/2/27.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

//This is first page after logging in
//The class is for the 3 kinds of cells of the dicover page
//Include the single header cell for the 16 buttons to search different kinds of restaurants
//A single map cell to show the location of user
//many restaurant cells, each for one result of the search
//and has a text field at the top to search by user's own term

#import "DiscoverTableViewController.h"
#import "HeaderTableViewCell.h"
#import "YELPAPISample.h"
#import <CoreLocation/CoreLocation.h>
#import "YelpListing.h"
#import "DiscoverTableViewCell.h"
#import "WebViewController.h"

@interface DiscoverTableViewController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *SearchedArray;
    NSMutableArray *YelpDataArray;
    BOOL issearchClicked;
    int pagenum;
    
}
@property (nonatomic, strong) NSMutableArray *objects;

@end

@implementation DiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // set refresh control
    UIRefreshControl *pullToRefresh = [[UIRefreshControl alloc] init];
    [pullToRefresh addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    pullToRefresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing"];
    
    self.refreshControl = pullToRefresh;
    self.refreshControl.bounds = CGRectMake(self.refreshControl.bounds.origin.x,
                                            -50,
                                            self.refreshControl.bounds.size.width,
                                            self.refreshControl.bounds.size.height);
    //initial the search text field
    self.searchTerm.delegate = self;
    
    //initial the location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Check for iOS 8
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    //initial the setting bundle
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // initial launch
    NSString* firstLaunchDate = [defaults objectForKey:@"first_launch_date"];
    NSDate* date = [NSDate date];
    
    if ([firstLaunchDate isEqualToString:@"First"]) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        
        [[NSUserDefaults standardUserDefaults] setObject:[dateFormatter stringFromDate:date] forKey:@"first_launch_date"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void)viewDidAppear:(BOOL)animated{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.delegate = self;
    self.refreshControl.layer.zPosition = self.tableView.backgroundView.layer.zPosition + 1;
    
    issearchClicked=NO;
    
    SearchedArray   =[[NSMutableArray alloc]init];
    YelpDataArray   =[[NSMutableArray alloc]init];
    
    // 8:00 AM to 9:00 PM
    pagenum=0;
    
    // Create a location manager
    self.latitude = self.locationManager.location.coordinate.latitude;
    self.longitude = self.locationManager.location.coordinate.longitude;
    
    //get the location
    NSString *myLocation = [NSString stringWithFormat:@"%f,%f", self.latitude,self.longitude];
    
    //set the color of navigationbar
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.view endEditing:YES];
    issearchClicked=NO;
    
    //return the bar
    [self getRestaurantsByLocation:myLocation islonglat:YES];
    [self.tableView reloadData];

    
}

//Refresh the location everytime turning to main page
- (void) refreshTable{
    self.latitude = self.locationManager.location.coordinate.latitude;
    self.longitude = self.locationManager.location.coordinate.longitude;
    
    NSString *myLocation = [NSString stringWithFormat:@"%f,%f", self.latitude,self.longitude];
    [self getRestaurantsByLocation:myLocation islonglat:YES];
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
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

//jump the header and map cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return YelpDataArray.count+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
   
    NSInteger rowNo = indexPath.row;
    if (rowNo == 0)//First row for the head cell
    {
        static NSString *cellId = @"HeaderCell";
        HeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        
        if (cell == nil)
        {
            cell = [[HeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.discover = self;
        return cell;
    }
    
    //second row for the map
    if (rowNo ==1){
        static NSString *cellId = @"MapCell";
        MapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        
        if (cell == nil)
        {
            cell = [[MapTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.locationManager = [[CLLocationManager alloc] init];
        cell.locationManager = self.locationManager;
        [cell.mapView setShowsUserLocation:YES];
        
        
        for (YelpListing * yelp in YelpDataArray) {
            NSLog(@"not here??");
            NSString *latitude = [yelp.coordinate valueForKey:@"latitude"];
            NSString *longitude = [yelp.coordinate valueForKey:@"longitude"];
            
            NSLog(@"location=%@",latitude);
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
            annotation.title = yelp.name;
            annotation.subtitle = yelp.display_phone;
            [cell.mapView addAnnotation:annotation];
        }
        
        MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = self.locationManager.location.coordinate.latitude;
        region.center.longitude = self.locationManager.location.coordinate.longitude;
        region.span.longitudeDelta = 0.10f;
        region.span.longitudeDelta = 0.10f;
        [cell.mapView setRegion:region animated:YES];
        [cell.mapView setCenterCoordinate:region.center animated:YES];
 
        return cell;
        
    }
    
    //others for the restaurant cells
    static NSString *CellIdentifier = @"RestaurantCell";
    
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setCellData:[YelpDataArray objectAtIndex:indexPath.row-2]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)//first cell for header
    {
        return 180.0f;
    }
    else
    {
        return 152.0f;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 1){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebViewController* webViewController = [storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
        
        YelpListing *ym=[YelpDataArray objectAtIndex:indexPath.row-2];
        webViewController.yelpObject=ym;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
       
}

#pragma mark - Segues

//alert if can not get the location
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Cannot get your location!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

//show the update info of the location right now
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        NSLog(@"longitude=%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        NSLog(@"latitude=%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        [self  getRestaurantsByLocation:[NSString stringWithFormat:@"%.8f,%.8f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude] islonglat:YES];
        [self.locationManager stopUpdatingLocation];
    }
}

//the function to search the restaurant by location
-(void)getRestaurantsByLocation:(NSString*)location islonglat:(BOOL)islonglat
{
    
    if ([location length]<1) return;
    
    // the default term is "rest,food"
    YELPAPISample *someApi=[YELPAPISample new];
    [someApi getServerResponseForLocation:location term:@"Restaurant,food" iSLonglat:islonglat withSuccessionBlock:^(NSDictionary *topBusinessJSON)
     {
         NSLog(@"Data From Server is %@",topBusinessJSON);
         
         if (!topBusinessJSON)
         {  
             NSLog(@"Response = Not avaialable");
             
             UIAlertView *myAlert=[[UIAlertView alloc]initWithTitle:@"Oops!!" message:@"Sorry! No listings found. Please search another location." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [myAlert show];
         }
         else
         {
             [self separAteParametres:topBusinessJSON];
         }
     } andFailureBlock:^(NSError *error) {
         
     }];
    
    if(self.refreshControl.refreshing){
        [self.refreshControl endRefreshing];
    }
    
}

//search the restaurant by term
-(void)getRestaurantsByTerm:(NSString*)term islonglat:(BOOL)islonglat
{
    if ([term length]<1) return;
    
    YELPAPISample *someApi=[YELPAPISample new];
    NSString *myLocation = [NSString stringWithFormat:@"%f,%f", self.latitude,self.longitude];
    [someApi getServerResponseForLocation:myLocation term:term iSLonglat:islonglat withSuccessionBlock:^(NSDictionary *topBusinessJSON)
     {
         NSLog(@"Data From Server is %@",topBusinessJSON);
         
         if (!topBusinessJSON)
         {
             NSLog(@"Response = Not avaialable");
             
             UIAlertView *myAlert=[[UIAlertView alloc]initWithTitle:@"Oops!!" message:@"Sorry! No listings found. Please search another location." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [myAlert show];
         }
         else
         {
             [self separAteParametres:topBusinessJSON];
         }
     } andFailureBlock:^(NSError *error) {
         
     }];
    [self.tableView reloadData];
    
}

//set the params using the api of yelp
-(void)separAteParametres:(NSDictionary*)params
{
    [YelpDataArray removeAllObjects];
    
    if ([params valueForKey:@"error"])
        return ;
    
    NSArray *businessArray=[params valueForKey:@"businesses"];
    for (NSDictionary *bdict in businessArray)
    {
        
        YelpListing *yelpModel=[YelpListing new];
        
        yelpModel.restaurant_id=[bdict valueForKey:@"id"];
        yelpModel.is_claimed=[bdict valueForKey:@"is_claimed"];
        yelpModel.is_closed=[bdict valueForKey:@"is_closed"];
        
        NSDictionary *locationDict= [bdict valueForKey:@"location"];
        
        yelpModel.city=[locationDict valueForKey:@"city"];
        yelpModel.address=[locationDict valueForKey:@"address"];
        yelpModel.coordinate=[locationDict valueForKey:@"coordinate"];
        yelpModel.country_code= [locationDict valueForKey:@"country_code"];
        
        NSArray *addressArray=[locationDict valueForKey:@"display_address"];
        
        NSString *final_Address=@"";
        for (NSString *sttring in addressArray){
            final_Address = [NSString stringWithFormat:@"%@, %@",final_Address,sttring];
        }
        
        
        yelpModel.display_address= final_Address;
        yelpModel.geo_accuracy= [locationDict valueForKey:@"geo_accuracy"];
        yelpModel.neighborhoods= [locationDict valueForKey:@"neighborhoods"];
        yelpModel.state_code=[locationDict valueForKey:@"state_code"];
        
        
        yelpModel.mobile_url=[bdict valueForKey:@"mobile_url"];
        yelpModel.name=[bdict valueForKey:@"name"];
        yelpModel.rating=[bdict valueForKey:@"rating"];
        yelpModel.rating_img_url=[bdict valueForKey:@"rating_img_url"];
        yelpModel.rating_img_url_large=[bdict valueForKey:@"rating_img_url_large"];
        yelpModel.rating_img_url_small=[bdict valueForKey:@"rating_img_url_small"];
        yelpModel.url=[bdict valueForKey:@"url"];
        yelpModel.review_count=[bdict valueForKey:@"review_count"];
        yelpModel.display_phone=[bdict valueForKey:@"display_phone"];
        if (!yelpModel.display_phone)
        {
            yelpModel.display_phone=([bdict valueForKey:@"phone"])?[bdict valueForKey:@"phone"]:@"Not updated";
        }
        yelpModel.image_url=[bdict valueForKey:@"image_url"];
        yelpModel.phone=[bdict valueForKey:@"phone"];
        
        yelpModel.snippet_image_url=[bdict valueForKey:@"snippet_image_url"];
        yelpModel.snippet_text=[bdict valueForKey:@"snippet_text"];
        
        [YelpDataArray addObject:yelpModel];
    }
    
    [self.tableView reloadData];
    
    
}

//search action, using the getRestaurantsByTerm
- (IBAction)search:(id)sender {
    
    //UITextField *textfield;
    NSString *textfield2;
    textfield2 = self.searchTerm.text;
    [self getRestaurantsByTerm:textfield2 islonglat:YES];
    [self.tableView reloadData];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
        status == kCLAuthorizationStatusAuthorizedAlways) {
        
        // Configure location manager
        [self.locationManager setDistanceFilter:kCLHeadingFilterNone];//]500]; // meters
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager setHeadingFilter:kCLDistanceFilterNone];
        self.locationManager.activityType = CLActivityTypeFitness;
        
        // Start the location updating
        [self.locationManager startUpdatingLocation];
        
        // Start beacon monitoring
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc]
                                                                                initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"]
                                                                    identifier:@"Estimotes"];
        [manager startRangingBeaconsInRegion:region];
        
        // Start region monitoring for Rio
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(-22.903,-43.2095);
        CLCircularRegion *bregion = [[CLCircularRegion alloc] initWithCenter:coordinate
                                                                      radius:100
                                                                  identifier:@"Rio"];
        region.notifyOnEntry = YES;
        region.notifyOnExit = YES;
        [self.locationManager startMonitoringForRegion:bregion];
        
        self.latitude = self.locationManager.location.coordinate.latitude;
        self.longitude = self.locationManager.location.coordinate.longitude;
        
        NSString *myLocation = [NSString stringWithFormat:@"%f,%f", self.latitude,self.longitude];
        [self getRestaurantsByLocation:myLocation islonglat:YES];
        
        
        // Show map
        
        [self.tableView reloadData];
        NSLog(@"if it is here!");
        
    } else if (status == kCLAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location services not authorized"
                                                        message:@"This app needs you to authorize locations services to work."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        NSLog(@"Wrong location status");
    }
}
//dismiss the text field after complete the inputting
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.searchTerm) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

//dismiss keyboard
-(void)dismissKeyboard {
    [self.searchTerm resignFirstResponder];
}
@end
