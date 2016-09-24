//
//  BookingField.m
//  CharterProject
//
//  Created by James Rochabrun on 9/23/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "BookingField.h"
#import "CommonUIConstants.h"
#import "Common.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"

@implementation BookingField


- (instancetype)initWithLabelName:(NSString *)labelName {
    
    self = [super init];
    if (self) {
        
        _labelField = [UILabel new];
        [self addSubview:_labelField];
        _labelField.text = labelName;
        [_labelField setFont:[UIFont regularFont:15]];
        [_labelField setTextColor:[UIColor customTextColor]];
        
        _textField = [UITextField new];
        [_textField setTextColor:[UIColor customTextColor]];
        [_textField setFont:[UIFont regularFont:15]];
        [self addSubview:_textField];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_labelField sizeToFit];
    CGRect frame = _labelField.frame;
    frame.origin.x = kGeomMarginMedium;
    frame.origin.y = kGeomSpaceEdge;
    _labelField.frame = frame;
    
    frame = _textField.frame;
    frame.size.height = kGeomHeightTextField;
    frame.size.width = width(self) * 0.8;
    frame.origin.x = kGeomMarginMedium;
    frame.origin.y = CGRectGetMaxY(_labelField.frame) + kGeomSpaceEdge;
    _textField.frame = frame;
    
}

@end
