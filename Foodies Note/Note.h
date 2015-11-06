//
//  Note.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/8.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject <NSCoding>

@property (strong, nonatomic) NSURL *link;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *restimageurl;

@property (strong, nonatomic) NSString *content;
//@property (strong, nonatomic) NSDate * date;
@property (strong, nonatomic) NSString * year;
@property (strong, nonatomic) NSString *month;
@property (strong, nonatomic) NSString * date;
@property (strong, nonatomic) NSString * week;
@property (strong, nonatomic) NSString * hour;
@property (strong, nonatomic) NSString * minute;
@property (strong, nonatomic) NSString * imagepath;
@property (strong, nonatomic) NSMutableArray *imagepaths;

@end
