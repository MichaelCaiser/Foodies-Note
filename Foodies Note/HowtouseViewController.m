//
//  HowtouseViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/13.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//


//This is the class for the how to use view
#import "HowtouseViewController.h"

@interface HowtouseViewController ()

@end

@implementation HowtouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.textview.text = @"This is a app for the people that want to find the gourmet food and record your review of every restaurant.\n\nFirst, you dont need to register for this app, but just using your facebook account. \n\nIn discover page, we will help you find all restaurants near you, or you can search your nearby restaurant by selecting type. \n\nIf you would like, you can checked in these restaurant and write a note on them by clicking write note button. You can add photos in your gallery take photos for you note. \n\nEnjoy recording:)";
    
    self.textview.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
