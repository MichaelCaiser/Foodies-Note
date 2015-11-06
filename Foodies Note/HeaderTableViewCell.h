//
//  HeaderTableViewCell.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/2/27.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverTableViewController.h"

@interface HeaderTableViewCell : UITableViewCell <UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) DiscoverTableViewController *discover;


@property CGFloat width;
@property CGFloat height;

@property NSInteger flag;

@end
