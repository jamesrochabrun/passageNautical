//
//  CharterCollectionViewCell.h
//  CharterProject
//
//  Created by James Rochabrun on 9/26/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubleTapImage.h"

@protocol CharterCollectionViewCellDelegate <NSObject>

- (void)callNumber;
- (void)sendEmail;

@end


@interface CharterCollectionViewCell : UICollectionViewCell<DoubleTapImageDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) DoubleTapImage *doubleTapImage;
@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) UIButton *emailButton;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *overlayImageView;
@property (nonatomic, weak) id<CharterCollectionViewCellDelegate>delegate;

@end
