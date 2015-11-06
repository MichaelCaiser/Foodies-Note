//
//  settingViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/12.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

//The class for the 4th tab view->infos
//include how to use, about us, share on facebook and alert of the rate app

#import "settingViewController.h"
#import "HowtouseViewController.h"
#import "LoginViewController.h"
#import "aboutusViewController.h"

@interface settingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation settingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Info";
    // Do any additional setup after loading the view.
    //Practising draw a table view using the programming
    [self drawTableView];
    //set the navigation bar
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}
-(void)drawTableView{
    //The view for iphone6(we test on iphone6)
    UITableView *tview = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [tview setDelegate:self];
    [tview setDataSource:self];
    [self.view addSubview:tview];
}

//set the height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

//rows in each section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
//using 3 sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    static NSString *CellIdentifier = @"settingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (section) {
            case 0:
                if(row == 0)
                {
                    cell.textLabel.text =  @"About Us";
                }else{
                    cell.textLabel.text =  @"Instructions";
                }
                break;
            case 1:
                cell.textLabel.text =  @"Share us on Facebook";
                break;
            case 2:
                cell.textLabel.text =  @"Rate this App";
                break;
            default:
                break;
        }
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    //for the about us
    if(section==0&&row==0){
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        aboutusViewController* aboutusview = [storyboard instantiateViewControllerWithIdentifier:@"test1"];
        
        
        [self.navigationController pushViewController:aboutusview animated:YES];
    }
    //for the how to use
    if(section==0&&row==1){
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HowtouseViewController* howtouseview = [storyboard instantiateViewControllerWithIdentifier:@"howtouseview"];
        
        
        [self.navigationController pushViewController:howtouseview animated:YES];
    }
    //for the share us on facebook
    if(section==1&&row==0){
        
        // Put together the dialog parameters
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Foodies Note", @"name",
                                       @"Food & Drink app looking forward your join! ", @"caption",
                                       @"We are helping foodies discover & record world! ", @"description",
                                       @"https://www.facebook.com/foodiesnote", @"link",
                                       @"http://telusers.com/image/2013/10/food-icon-png-5119-hd-wallpapers.png", @"picture",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User cancelled.
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
    //for the rate this app alert
    if (section ==2) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Rate this App"
                              message:@"Please rate this app in the app store!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
   
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
