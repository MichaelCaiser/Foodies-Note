//
//  MeTableViewController.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface MeTableViewController : UITableViewController

@property NSMutableArray *checkinItems;
@property (strong,nonatomic) FBProfilePictureView *profilePicture;
@property NSString *level;
@property NSString *checkinNum;
@end
