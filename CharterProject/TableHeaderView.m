//
//  TableHeaderView.m
//  CharterProject
//
//  Created by James Rochabrun on 10/5/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "TableHeaderView.h"
#import "Common.h"
#import "UIFont+CustomFont.h"
#import "UIColor+MainColor.h"

@implementation TableHeaderView

- (instancetype)initWithHeaderTitle:(NSString *)title {
    
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _headerLabel = [UILabel new];
        _headerLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _headerLabel.numberOfLines = 0;
        _headerLabel.text = title;
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        [_headerLabel setFont:[UIFont regularFont:20]];
        [_headerLabel setTextColor:[UIColor customMainColor]];
        [self addSubview:_headerLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
        
    [_headerLabel sizeToFit];
    CGRect frame = _headerLabel.frame;
    frame.origin.x = (width(self) - width(_headerLabel)) / 2;
    frame.origin.y = (height(self) - height(_headerLabel)) /2;
    _headerLabel.frame = frame;
}

@end
