//
//  NoteDetailViewController.h
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/12.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *restimage;
@property (weak, nonatomic) IBOutlet UILabel *restname;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet UILabel *restlocation;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *textview;

@property Note * notedetail;
@property (strong, nonatomic) NSMutableArray* imagepaths;

@end
