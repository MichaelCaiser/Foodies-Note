//
//  LoginViewController.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/7.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end

