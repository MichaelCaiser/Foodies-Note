//
//  WriteNoteViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/7.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

//The core class to write a note, show the rest info, write the notes in the textview
//take photos of the food or choose from photos, show in the collection view
//save all the rest info, date, note content, and all the imagepath into the plist, that can be used in the
// note detail page

#import "WriteNoteViewController.h"
#import "AsyncImageView.h"
#import "PhotoCollectionViewCell.h"
#import "NotesTableViewController.h"
#import "DiscoverTableViewController.h"


@interface WriteNoteViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property BOOL isFullScreen;
@property NSInteger photonumber;

@end

@implementation WriteNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Text.placeholder = @"Say something...";
    [self.Text becomeFirstResponder];
    
    self.view.userInteractionEnabled= YES;
    self.photonumber = 0;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.imagepaths=[[NSMutableArray alloc]initWithCapacity:5];
    //[self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];
    
    //initial the date of the note
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    //judge the month
    self.year.text = [NSString stringWithFormat: @"%ld", (long)year];
    if (month == 1) {
        self.month.text = [NSString stringWithFormat: @"JAN"];
    }
    else if(month == 2){
        self.month.text = [NSString stringWithFormat: @"FEB"];
    }
    else if(month == 3){
        self.month.text = [NSString stringWithFormat: @"MAR"];
    }
    else if(month == 4){
        self.month.text = [NSString stringWithFormat: @"APR"];
    }
    else if(month == 5){
        self.month.text = [NSString stringWithFormat: @"MAY"];
    }
    else if(month == 6){
        self.month.text = [NSString stringWithFormat: @"JUN"];
    }
    else if(month == 7){
        self.month.text = [NSString stringWithFormat: @"JUL"];
    }
    else if(month == 8){
        self.month.text = [NSString stringWithFormat: @"AUG"];
    }
    else if(month == 9){
        self.month.text = [NSString stringWithFormat: @"SEP"];
    }
    else if(month == 10){
        self.month.text = [NSString stringWithFormat: @"OCT"];
    }
    else if(month == 11){
        self.month.text = [NSString stringWithFormat: @"NOV"];
    }
    else if(month == 12){
        self.month.text = [NSString stringWithFormat: @"DEC"];
    }
    self.restname.text = self.yelpObject.name;
    self.restimage.imageURL =[NSURL URLWithString:self.yelpObject.image_url];

    
    NSString *add = [self.yelpObject.display_address description];
    NSString *newAdd = [add substringFromIndex:2];
    
    self.restlocation.text = newAdd;
    
    self.day.text = [NSString stringWithFormat: @"%ld", (long)day];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 180.0-1, self.view.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    [self.view addSubview:line];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 300.0-1, self.view.frame.size.width, 1)];
    line2.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    [self.view addSubview:line2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                initWithTarget:self
                              action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.image.autoresizesSubviews = NO;
    [self.collectionView reloadData];
   
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//the action of saving note, save all the info into notes.plist
- (IBAction)saveNote:(id)sender {
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"notes.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    NSArray * notesArray = (NSArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray * tmp = nil;
    if (notesArray) {
        tmp = [[NSMutableArray alloc] initWithArray:notesArray];
    } else {
        tmp = [[NSMutableArray alloc] init];
    }
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  currenttime=[dateformatter stringFromDate:senddate];
    NSLog(@"123=%@",currenttime);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger year = [comps year];
    NSInteger week = [comps weekday];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];

  
    //store the exact object note
    Note * note = [[Note alloc] init];
    note.content = self.Text.text;
    note.year = [NSString stringWithFormat: @"%ld", (long)year];
    if (month == 1) {
        note.month = [NSString stringWithFormat: @"JAN  "];
    }
    else if(month == 2){
        note.month = [NSString stringWithFormat: @"FEB  "];
    }
    else if(month == 3){
        note.month = [NSString stringWithFormat: @"MAR  "];
    }
    else if(month == 4){
        note.month = [NSString stringWithFormat: @"APR  "];
    }
    else if(month == 5){
        note.month = [NSString stringWithFormat: @"MAY  "];
    }
    else if(month == 6){
        note.month = [NSString stringWithFormat: @"JUN  "];
    }
    else if(month == 7){
        note.month = [NSString stringWithFormat: @"JUL  "];
    }
    else if(month == 8){
        note.month = [NSString stringWithFormat: @"AUG  "];
    }
    else if(month == 9){
        note.month = [NSString stringWithFormat: @"SEP  "];
    }
    else if(month == 10){
        note.month = [NSString stringWithFormat: @"OCT  "];
    }
    else if(month == 11){
        note.month = [NSString stringWithFormat: @"NOV  "];
    }
    else if(month == 12){
        note.month = [NSString stringWithFormat: @"DEC  "];
    }
    
    //judge the weekday
    if (week == 1) {
        note.week = [NSString stringWithFormat: @"Sunday"];
    }
    else if(week == 2){
        note.week = [NSString stringWithFormat: @"Monday"];
    }
    else if(week == 3){
        note.week = [NSString stringWithFormat: @"Tuesday"];
    }
    else if(week == 4){
        note.week = [NSString stringWithFormat: @"Wednesday"];
    }
    else if(week == 5){
        note.week = [NSString stringWithFormat: @"Thursday"];
    }
    else if(week == 6){
        note.week = [NSString stringWithFormat: @"Friday"];
    }
    else if(week == 7){
        note.week = [NSString stringWithFormat: @"Saturday"];
    }
    //    note.week = [NSString stringWithFormat: @"%ld", (long)week];

    note.date = [NSString stringWithFormat: @"%ld", (long)day];

    note.hour = [NSString stringWithFormat: @"%ld", (long)hour];

    note.minute = [NSString stringWithFormat: @"%ld", (long)min];
    
    note.imagepath = self.imagepath;
    
    note.imagepaths = self.imagepaths;
    
    note.title = self.restname.text;
    
    note.location = self.restlocation.text;
    
    note.restimageurl = self.yelpObject.image_url;

    [tmp addObject:note];
    
    NSData * notes = [NSKeyedArchiver archivedDataWithRootObject:tmp];
    [notes writeToURL:file atomically:NO];
    
    //goback to main page after saving the note
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController* controller = [storyboard instantiateViewControllerWithIdentifier:@"rootController"];
    [self presentViewController:controller animated:YES completion:nil];
}

//change the image to data type and then write to file
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    //get the catalog of the sandbox

    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [paths objectAtIndex:0];
    
    //get the full path and write to file
    
    NSString * file = [documentDirectory stringByAppendingPathComponent:imageName];

    [imageData writeToFile:file atomically:YES];
}
//image picker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //NSString *
    NSDate *  senddate=[NSDate date];

    self.photonumber = self.photonumber+1;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *  currenttime=[dateFormatter stringFromDate:senddate];
    //using the date of the picture to be the path
    NSString *imagename = [[NSString alloc] initWithFormat:@"%@-%ld.png",currenttime,(long)self.photonumber];
    //show the paths
    NSLog(@"imagename==%@",imagename);
    NSLog(@"imagepaths==%@",self.imagepaths);
    
    [self saveImage:image withName:imagename];
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [paths objectAtIndex:0];
    
    //get the full path and the savedimage
    
    NSString * fullPath = [documentDirectory stringByAppendingPathComponent:imagename];
    
    self.imagepath = fullPath;
    [self.imagepaths addObject:fullPath];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    _isFullScreen = NO;
    [self.image setImage:savedImage];
    
    self.image.tag = 100;
    [self.collectionView reloadData];
    
}
//cancel
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
// larger and smaller of the photos
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    _isFullScreen = !_isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.image.frame.origin;
    //touchPoint.x ，touchPoint.y
    
    // judge the tap point, in the view or out?
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.image.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.image.frame.size.height >= touchPoint.y)
    {
        // set begin
        [UIView beginAnimations:nil context:nil];
        // time of the animation
        [UIView setAnimationDuration:1];
        
        if (_isFullScreen) {
            // larger
            
            self.image.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // samller
            self.image.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit
        [UIView commitAnimations];
        
    }
    
}

#pragma mark - actionsheet delegate
//action sheet after tap the button
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // judge if it support the camera
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    //cancel
                    return;
                case 1:
                    // camera
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // photos
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // jump to the page of photos or camera
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        //[imagePickerController release];
    }
}


//the action to choose photo
// two possible outcomes

- (IBAction)choosephoto:(id)sender {
    
    UIActionSheet *sheet;
    
    //judge if it support the camera
    //show two selective or three(whether can take a photo or just choose from photos)
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"Select" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Take Photo",@"Choose from Photos", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"Select" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Choose from Photos", nil];
    }
    
    sheet.tag = 255;

    [sheet showInView:self.view];
}

-(void)dismissKeyboard {
    [self.Text resignFirstResponder];
}



#pragma mark - CollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photonumber+1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger rowNo = indexPath.row;
    NSLog(@"photonumber=%ld",(long)self.photonumber);
    
    if (rowNo<self.photonumber) {
        //static NSString *cellId = @"photoCell";
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
        
        NSString *imageToLoad = [self.imagepaths objectAtIndex:rowNo];
        //load the image
        NSLog(@"imagetoload=%@",imageToLoad);
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:imageToLoad];
        
        //_isFullScreen = NO;
        [cell.singlephoto setImage:savedImage];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
    else
    {
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor blackColor];
        
        return cell;
    
    }
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120, 120);
}
//define the margin of each UICollectionView
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


@end
