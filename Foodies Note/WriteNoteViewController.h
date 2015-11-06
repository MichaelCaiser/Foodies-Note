//
//  WriteNoteViewController.h
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/7.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NotesTableViewController.h"
#import "CPTextViewPlaceholder.h"
#import "YelpListing.h"

@interface WriteNoteViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


- (IBAction)saveNote:(id)sender;
//@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) NSString * imagepath;
@property (weak, nonatomic) IBOutlet UILabel *restlocation;
@property (weak, nonatomic) IBOutlet CPTextViewPlaceholder *Text;
@property (weak, nonatomic) IBOutlet UIImageView *restimage;
@property (weak, nonatomic) IBOutlet UILabel *restname;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *day;

@property (strong, nonatomic) YelpListing *yelpObject;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(strong, nonatomic) NSMutableArray* imagepaths;


@property NotesTableViewController *noteview;

- (IBAction)choosephoto:(id)sender;


@end
