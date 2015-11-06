//
//  PersonalCheckInTableViewCell.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface PersonalCheckInTableViewCell : UITableViewCell <FBLoginViewDelegate>



@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *checkinNum;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *FBPicture;

@end
