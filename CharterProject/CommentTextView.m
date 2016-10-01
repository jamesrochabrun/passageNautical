//
//  CommentTextView.m
//  CharterProject
//
//  Created by James Rochabrun on 9/30/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CommentTextView.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"
#import "CommonUIConstants.h"
#import "Common.h"

@implementation CommentTextView

- (instancetype)initWithLabelName:(NSString *)labelName {
    
    self = [super init];
    if (self) {
        
        _label = [UILabel new];
        [self addSubview:_label];
        _label.text = labelName;
        [_label setFont:[UIFont regularFont:15]];
        [_label setTextColor:[UIColor customTextColor]];
        
        _textView = [UITextView new];
        [_textView setTextColor:[UIColor customTextColor]];
        [_textView setFont:[UIFont regularFont:15]];
        _textView.delegate = self;
        _textView.scrollEnabled = YES;
        _textView.layer.borderColor = [UIColor customMainColor].CGColor;
        _textView.layer.borderWidth = 1.0f;
        [self addSubview:_textView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_label sizeToFit];
    CGRect frame = _label.frame;
    frame.origin.x = kGeomMarginBig;
    frame.origin.y = kGeomSpaceEdge;
    _label.frame = frame;
    
    frame = _textView.frame;
    frame.size.height = 100;
    frame.size.width = width(self) * 0.75;
    frame.origin.x = (width(self) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_label.frame) + kGeomSpaceEdge *2;
    _textView.frame = frame;
    
}


@end
