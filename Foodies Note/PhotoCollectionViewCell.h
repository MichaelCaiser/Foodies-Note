//
//  PhotoCollectionViewCell.h
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

//The class for the collection cell in the writenote page
//each cell has a imageview of photo
#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *singlephoto;

@end
