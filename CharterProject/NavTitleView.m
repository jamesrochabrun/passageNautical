//
//  NavTitleView.m
//  CharterProject
//
//  Created by James Rochabrun on 10/27/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "NavTitleView.h"
#import "UIFont+CustomFont.h"
#import "UIColor+MainColor.h"
#import "Common.h"

@interface NavTitleView ()
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UILabel *subHeaderLabel;

@end

@implementation NavTitleView

- (id)init {
    
    self = [super init];
    if (self) {
        
        _headerLabel = [UILabel new];
        [_headerLabel setFont:[UIFont regularFont:14]];
        _headerLabel.textColor = [UIColor customTextColor];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _headerLabel.numberOfLines = 0;
        [self addSubview:_headerLabel];
        
        _subHeaderLabel = [UILabel new];
        _subHeaderLabel.font = [UIFont regularFont:15];
        _subHeaderLabel.textColor = [UIColor customTextColor];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
       // [self addSubview:_subHeaderLabel];
        
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = _headerLabel.frame;
    frame.size.height = 44;
    frame.size.width = width(self) * 0.8;
    frame.origin.x =  0;// (width(self) - frame.size.width) /2;
    frame.origin.y = (height(self.superview) - frame.size.height) /2;
    _headerLabel.frame = frame;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _headerLabel.text = _title;
    
    __weak NavTitleView *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf setNeedsLayout];
    });
}





@end
