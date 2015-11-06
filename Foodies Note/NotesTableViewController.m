//
//  NotesTableViewController.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/8.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

//the class to show all the notes of the user
// showthe date, picture and some info of the rest in each cell
//can also share using the facebook
#import "NotesTableViewController.h"
#import "NoteTableViewCell.h"
#import "NoteDetailViewController.h"
#import "AsyncImageView.h"
#import "LoginViewController.h"

@interface NotesTableViewController ()

@end

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set the navigationbar and item
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.staticedit = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                       style:UIBarButtonItemStyleDone
                                                      target:self action:@selector(edit)];
    self.navigationItem.leftBarButtonItem = self.staticedit;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"notes.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    self.notes = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteTableViewCell *cell = (NoteTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    
     // Configure the cell... get the data from the exact object note
    Note *object = self.notes[self.notes.count-indexPath.row-1];
    
    cell.year.text = object.year;
    cell.month.text = object.month;
    cell.day.text = object.date;
    cell.week.text = object.week;
    cell.title.text = object.title;
    cell.content.text = object.content;
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:object.imagepath];
    NSLog(@"imagepath==%@",object.imagepath);
    NSLog(@"day==%@",object.date);
    if (object.imagepath!=nil) {
        cell.image.image = savedImage;
    }
    else
    {
        cell.image.imageURL = [NSURL URLWithString:object.restimageurl];
    }
    
   
    
    return cell;
}

//share on facebook
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 1){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NoteDetailViewController* detailview = [storyboard instantiateViewControllerWithIdentifier:@"notedetailview"];
        
        
        Note *object = self.notes[self.notes.count-indexPath.row-1];
        detailview.notedetail = object;
        
        UIBarButtonItem *shareFB = [[UIBarButtonItem alloc]
                                                      initWithTitle:@"ShareFB"
                                                      style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(shareInFB)];
        detailview.navigationItem.rightBarButtonItem = shareFB;
        shareFB.image = [UIImage imageNamed:@"facebook.png"];
        [self.navigationController pushViewController:detailview animated:YES];
    }
    
}


//edit mode(delete the cell)
- (void)edit {
    if ([self.tableView isEditing]) {
        // If the tableView is already in edit mode, turn it off. Also change the title of the button to reflect the intended verb (‘Edit’, in this case).
        [self.tableView setEditing:NO animated:YES];
        [self.staticedit setTitle:@"Edit"];
        
        
    }else {
        // Turn on edit mode
        [self.tableView setEditing:YES animated:YES];
        
        [self.staticedit setTitle:@"Done"];
    }
}

//delete the cell in the plist
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //delete mode
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //delete
        [self.notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //update disc
        NSError * err = nil;
        NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
        NSURL *file = [docs URLByAppendingPathComponent:@"notes.plist"];
        NSData * note = [NSKeyedArchiver archivedDataWithRootObject:self.notes];
        [note writeToURL:file atomically:NO];
        
        //DetailViewController *controller = [[DetailViewController alloc]init];
        
        
    }
}

//share in fb
- (void) shareInFB {
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:nil
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User canceled.
                                                          NSLog(@"User cancelled.");
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User canceled.
                                                              NSLog(@"User cancelled.");
                                                              
                                                          } else {
                                                              // User clicked the Share button
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
    
}

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}
@end
