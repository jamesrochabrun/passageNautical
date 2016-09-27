//
//  UICollectionView+Additions.h
//  CharterProject
//
//  Created by James Rochabrun on 9/26/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Additions)
+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout inView:(UIView *)view delegate:(id)delegate;
+ (UICollectionView *)collectionViewInView:(UIView *)view direction:(UICollectionViewScrollDirection)direction withItemSize:(CGSize)itemSize delegate:(id)delegate;

@end
