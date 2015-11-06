//
//  NoteDetailViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/12.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

//This is the page after selecting the exact note cell 
//The class for the detail page of every note
//it will show all the info of the restaurant, your note content, date, and all the photos that stored in the plist

#import "NoteDetailViewController.h"
#import "AsyncImageView.h"
#import "SelfPhotoCollectionViewCell.h"

@interface NoteDetailViewController ()<UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation NoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    
    //set the text and image corresponding to the exact note object
    // Do any additional setup after loading the view.
    self.restname.text = self.notedetail.title;
    self.restlocation.text = self.notedetail.location;
    self.year.text = self.notedetail.year;
    self.month.text = self.notedetail.month;
    self.date.text = self.notedetail.date;
    self.textview.text = self.notedetail.content;
    self.restimage.imageURL = [NSURL URLWithString:self.notedetail.restimageurl];
    self.imagepaths = self.notedetail.imagepaths;

    [self.collectionview reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - CollectionView DataSource2
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagepaths.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger rowNo = indexPath.row;
    SelfPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"singleCell" forIndexPath:indexPath];
        
        
    NSString *imageToLoad = [self.imagepaths objectAtIndex:rowNo];
    
    //load the picture from the path in the plist
    NSLog(@"imagepath=%@",imageToLoad);
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:imageToLoad];
        
        //_isFullScreen = NO;
    [cell.singleimage setImage:savedImage];
        
    cell.backgroundColor = [UIColor whiteColor];
        
    return cell;

    
}

//set the layout of the collection views
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
