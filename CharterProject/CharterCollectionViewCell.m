//
//  CharterCollectionViewCell.m
//  CharterProject
//
//  Created by James Rochabrun on 9/26/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CharterCollectionViewCell.h"
#import "Common.h"
#import "UIFont+CustomFont.h"
#import "CommonUIConstants.h"

@implementation CharterCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        _phoneButton = [UIButton new];
        [_phoneButton addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
        [_phoneButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [_phoneButton setTintColor:[UIColor whiteColor]];
        [self addSubview:_phoneButton];
        
        _emailButton = [UIButton new];
        [_emailButton addTarget:self action:@selector(email) forControlEvents:UIControlEventTouchUpInside];
        
        [_emailButton setImage:[UIImage imageNamed:@"mail"] forState:UIControlStateNormal];
        [_emailButton setTintColor:[UIColor whiteColor]];
        [self addSubview:_emailButton];
        
        _priceLabel = [UILabel new];
        [_priceLabel setFont:[UIFont regularFont:17]];
        [_priceLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:_priceLabel];
            
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = _imageView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = width(self);
    frame.size.height = height(self);
    _imageView.frame = frame;
    
    [_priceLabel sizeToFit];
    frame = _priceLabel.frame;
    frame.origin.x = kGeomSpaceEdge *2;
    frame.origin.y = CGRectGetMaxY(self.frame) - _priceLabel.frame.size.height - kGeomSpaceEdge *2;
    _priceLabel.frame = frame;
    
    frame = _emailButton.frame;
    frame.size.width = kGeomContactButton;
    frame.size.height = kGeomContactButton;
    frame.origin.y = CGRectGetMaxY(self.frame) - frame.size.height - kGeomSpaceEdge *2;
    frame.origin.x = CGRectGetMaxX(self.frame) - frame.size.width - kGeomSpaceEdge *2;
    _emailButton.frame = frame;
    
    frame = _phoneButton.frame;
    frame.size.width = kGeomContactButton;
    frame.size.height = kGeomContactButton;
    frame.origin.x = CGRectGetMinX(_emailButton.frame) - frame.size.width - kGeomSpaceEdge *2;
    frame.origin.y = CGRectGetMaxY(self.frame) - frame.size.height - kGeomSpaceEdge *2;
    _phoneButton.frame = frame;
    
}

- (void)call {
    [self.delegate callNumber];
}

- (void)email {
    [self.delegate sendEmail];
}

@end
