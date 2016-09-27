//
//  UICollectionView+Additions.m
//  CharterProject
//
//  Created by James Rochabrun on 9/26/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "UICollectionView+Additions.h"
#import "CommonUIConstants.h"
#import "UIColor+MainColor.h"

@implementation UICollectionView (Additions)

+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout inView:(UIView *)view delegate:(id)delegate {
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = delegate;
    collectionView.dataSource = delegate;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.alwaysBounceHorizontal = NO;
    collectionView.allowsSelection = YES;
    collectionView.backgroundColor = [UIColor customTextColor];
    [view addSubview:collectionView];
    return collectionView;
}

+ (UICollectionView *)collectionViewInView:(UIView *)view direction:(UICollectionViewScrollDirection)direction withItemSize:(CGSize)itemSize delegate:(id)delegate {
    
    UICollectionViewFlowLayout *cvLayout = [[UICollectionViewFlowLayout alloc] init];
    cvLayout.itemSize = itemSize;
    cvLayout.scrollDirection = direction;
    cvLayout.minimumInteritemSpacing = kGeomMinimunInterItemSpacing;
    cvLayout.minimumLineSpacing = kGeomSpaceCellPadding;
    return [UICollectionView collectionViewWithLayout:cvLayout inView:view delegate:delegate];
}

@end
