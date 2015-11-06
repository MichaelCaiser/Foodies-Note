//
//  MapTableViewCell.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/9.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;


@interface MapTableViewCell : UITableViewCell <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocation *location;
@property (strong,nonatomic) CLLocationManager *locationManager;

@end
