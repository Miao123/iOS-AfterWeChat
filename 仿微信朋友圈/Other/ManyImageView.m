//
//  ManyImageView.m
//  多张图片显示
//
//  Created by 苗建浩 on 2017/5/8.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "ManyImageView.h"
#import "ImageCollCell.h"
#import "Header.h"
#define ImageWidthClearance 3   //  图片之间横向的缝隙大小
#define ImageHeightClearance 3  //  图片之间纵向的缝隙大小
//  小图的大小
#define ImageWidth ((screenWidth - 12 - 6) / 3)
//  全图的大小
#define AllImageWidth (screenWidth - 6)

@interface ManyImageView()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) ManyImageView *imageShow;
@property (nonatomic, strong) UIScrollView *imageScroll;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UICollectionView *imageColl;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, assign) int imageCount;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) int widthMargin;

@end

@implementation ManyImageView

+ (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr numberRow:(int)numberRow widthClearance:(int)widthMargin{
    
    ManyImageView *imageShow = [[ManyImageView alloc] initWithFrame:frame];
    imageShow.number = numberRow;
    imageShow.imageArr = imageArr;
    imageShow.widthMargin = widthMargin;
    imageShow.imageCount = (int)imageArr.count;
    [imageShow frame:frame imageWithArr:imageArr];
    imageShow.imageShow = imageShow;
    return imageShow;
}


- (void)frame:(CGRect)frame imageWithArr:(NSArray *)imageArr{
    
    UIScrollView *imageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHight)];
    imageScroll.backgroundColor = [UIColor blackColor];
    imageScroll.contentSize = CGSizeMake(screenWidth * imageArr.count, screenHight);
    imageScroll.pagingEnabled = YES;
    imageScroll.bounces = NO;
    imageScroll.alpha = 0;
    imageScroll.delegate = self;
    self.imageScroll = imageScroll;
    imageScroll.userInteractionEnabled = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:imageScroll];
    
    
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3 + screenWidth * i, (screenHight - AllImageWidth) / 2, AllImageWidth, AllImageWidth)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[i]]];
        imageView.userInteractionEnabled = YES;
        [imageScroll addSubview:imageView];
    }
    
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((screenWidth - 20) / 2, screenHight - 50, 20, 20);
    pageControl.numberOfPages = imageArr.count;
    pageControl.currentPage = 0;
    pageControl.hidden = YES;
    pageControl.pageIndicatorTintColor = RGB_COLOR(70, 70, 70);
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl = pageControl;
    [[UIApplication sharedApplication].keyWindow addSubview:pageControl];
    
    
    UITapGestureRecognizer *scrTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrTap:)];
    scrTap.numberOfTapsRequired = 1;
    scrTap.numberOfTouchesRequired = 1;
    [imageScroll addGestureRecognizer:scrTap];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = ImageHeightClearance;
    layout.minimumInteritemSpacing = ImageWidthClearance;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    UICollectionView *imageColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, CGRectGetHeight(self.bounds)) collectionViewLayout:layout];
    imageColl.delegate = self;
    imageColl.dataSource = self;
    imageColl.backgroundColor = [UIColor clearColor];
    //    imageColl.alwaysBounceVertical = YES;
    [imageColl registerClass:[ImageCollCell class] forCellWithReuseIdentifier:@"cell"];
    self.imageColl = imageColl;
    [self addSubview:imageColl];
    
}


#pragma mark ------- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    ImageCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell creatArr:_imageArr indexRow:(int)indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, _widthMargin, 0, _widthMargin);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((screenWidth - 70 * DISTENCEW - 2 * _widthMargin - (ImageWidthClearance * _number - 1)) / _number, (screenWidth - 70 * DISTENCEW - 2 * _widthMargin - (ImageWidthClearance * _number - 1)) / _number);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger tag = indexPath.row;
    
    self.imageScroll.contentOffset = CGPointMake(screenWidth * tag, 0);
    [UIView animateWithDuration:0.3 animations:^{
        self.imageScroll.alpha = 1;
    } completion:^(BOOL finished) {
        _pageControl.hidden = NO;
    }];
}


- (void)scrTap:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.3 animations:^{
        self.imageScroll.alpha = 0;
        _pageControl.hidden = YES;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetX = scrollView.contentOffset.x;
    int number = offSetX / screenWidth;
    _pageControl.currentPage = number;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
