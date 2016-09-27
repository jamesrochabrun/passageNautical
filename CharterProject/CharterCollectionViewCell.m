//
//  CharterCollectionViewCell.m
//  CharterProject
//
//  Created by James Rochabrun on 9/26/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CharterCollectionViewCell.h"
#import "Common.h"

@implementation CharterCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
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
    
}

@end
