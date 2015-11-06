//
//  NotesTableViewController.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/8.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NotesTableViewController : UITableViewController

@property NSMutableArray *notes;

- (void) edit;
@property (strong, nonatomic) UIBarButtonItem *staticedit;

@end
