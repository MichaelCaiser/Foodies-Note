//
//  HeaderTableViewCell.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/2/27.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    self.width = screenWidth;
    self.height = 160;
    
    //initial scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    //self.scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(self.width * 2, self.height);
    self.scrollView.delegate = self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(70,70);
    UIEdgeInsets top = {10,10,10,10};
    flowLayout.sectionInset = top;
    
    UICollectionView *firstView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height+20) collectionViewLayout:flowLayout];
    firstView.backgroundColor = [UIColor whiteColor];
    
    //register for the first cell
    [firstView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"firstCellId"];
    firstView.tag = 10001;
    firstView.delegate   = self;
    firstView.dataSource = self;
    
    UICollectionView *secondView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height+20) collectionViewLayout:flowLayout];
    secondView.backgroundColor = [UIColor whiteColor];
    //register for the second cell
    [secondView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"secondCellId"];
    secondView.tag = 10002;
    secondView.delegate   = self;
    secondView.dataSource = self;
    
    [_scrollView addSubview:firstView];
    [_scrollView addSubview:secondView];
    
    //initial the pageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_scrollView.bounds.size.height,self.bounds.size.width,20)];
    //self.pageControl.frame=CGRectMake(0,_scrollView.bounds.size.height,self.bounds.size.width,20);
    _pageControl.backgroundColor = [UIColor whiteColor];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 2;
    _pageControl.userInteractionEnabled = YES;
    
    //add two lines to devide the view
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 180.0-0.5, self.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    [self addSubview:line];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//the style of the header cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //get the size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    self.width = screenWidth;
    self.height = 160;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //initial the scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(self.width * 2, self.height);
        _scrollView.delegate = self;
        
        //frame for each button
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(60,60);
        UIEdgeInsets top = {20,30,20,30};
        flowLayout.sectionInset = top;
        
        //the first page of the scroll view
        UICollectionView *firstView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height+20) collectionViewLayout:flowLayout];
        firstView.backgroundColor = [UIColor whiteColor];
        //register
        [firstView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"firstCellId"];
        firstView.tag = 10001;
        firstView.delegate   = self;
        firstView.dataSource = self;
        
        //the second page , continue the x point of first page
        UICollectionView *secondView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height+20) collectionViewLayout:flowLayout];
        secondView.backgroundColor = [UIColor whiteColor];
        //register
        [secondView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"secondCellId"];
        secondView.tag = 10002;
        secondView.delegate   = self;
        secondView.dataSource = self;
        
        //add the views
        [_scrollView addSubview:firstView];
        [_scrollView addSubview:secondView];
        
        //initial the pageControl
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_scrollView.bounds.size.height,self.bounds.size.width,20)];
        _pageControl.backgroundColor = [UIColor whiteColor];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
        _pageControl.userInteractionEnabled = YES;
        
        //add two lines
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 180.0-0.5, self.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
        
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        [self addSubview:line];
        
    }
    return self;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _scrollView.bounds.size.width;
    // change to new page if scroll over 50% of the old page
    int page = floor(_scrollView.contentOffset.x / pageWidth);
    _pageControl.currentPage = page;
    self.flag = page;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//8 buttons for each page
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = nil;
    NSInteger index = 0;
    if (collectionView.tag == 10001)
    {
        identify = @"firstCellId";
        index = 1;
    }
    else
    {
        identify = @"secondCellId";
        index = 9;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%ld.png",(indexPath.row + index)]]];
    return cell;
}

//different buttons correspond to different kinds(term) of food
//the location is the user's location right now
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger iconnumber;
    iconnumber = self.flag*8 + indexPath.row;
    NSLog(@"lalala=%ld",(long)iconnumber);
    if(iconnumber == 0)
    {
        [self.discover getRestaurantsByTerm:@"mexian" islonglat:YES];
    }
    if(iconnumber == 1)
    {
        [self.discover getRestaurantsByTerm:@"coffee" islonglat:YES];
    }
    if(iconnumber == 2)
    {
        [self.discover getRestaurantsByTerm:@"donut" islonglat:YES];
    }
    if(iconnumber == 3)
    {
        [self.discover getRestaurantsByTerm:@"pizza" islonglat:YES];
    }
    if(iconnumber == 4)
    {
        [self.discover getRestaurantsByTerm:@"grill" islonglat:YES];
    }
    if(iconnumber == 5)
    {
        [self.discover getRestaurantsByTerm:@"icecream" islonglat:YES];
    }
    if(iconnumber == 6)
    {
        [self.discover getRestaurantsByTerm:@"hot dog" islonglat:YES];
    }
    if(iconnumber == 7)
    {
        [self.discover getRestaurantsByTerm:@"pop corn" islonglat:YES];
    }
    if(iconnumber == 8)
    {
        [self.discover getRestaurantsByTerm:@"fries" islonglat:YES];
    }
    if(iconnumber == 9)
    {
        [self.discover getRestaurantsByTerm:@"drink" islonglat:YES];
    }
    if(iconnumber == 10)
    {
        [self.discover getRestaurantsByTerm:@"bread" islonglat:YES];
    }
    if(iconnumber == 11)
    {
        [self.discover getRestaurantsByTerm:@"cake" islonglat:YES];
    }
    if(iconnumber == 12)
    {
        [self.discover getRestaurantsByTerm:@"tea" islonglat:YES];
    }
    if(iconnumber == 13)
    {
        [self.discover getRestaurantsByTerm:@"beer" islonglat:YES];
    }
    if(iconnumber == 14)
    {
        [self.discover getRestaurantsByTerm:@"burger" islonglat:YES];
    }
    if(iconnumber == 15)
    {
        [self.discover getRestaurantsByTerm:@"chinese" islonglat:YES];
    }
    
}



//click to change the page
-(void)changePage:(UIPageControl *)sender
{
    NSInteger page = sender.currentPage;
    [_scrollView setContentOffset:CGPointMake(self.width * page, 0) animated:YES];
}


@end
