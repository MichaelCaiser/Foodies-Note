//
//  MapCheckInTableViewCell.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface MapCheckInTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property NSMutableArray *checkInDataArray;


@end
