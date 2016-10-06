//
//  DateTableViewCell.m
//  CharterProject
//
//  Created by James Rochabrun on 10/4/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "DateTableViewCell.h"
#import "UIFont+CustomFont.h"
#import "UIColor+MainColor.h"
#import "CommonUIConstants.h"
#import "Common.h"

@implementation DateTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier];
 
    if (self) {
        
        _dateLabel = [UILabel new];
        [_dateLabel setFont:[UIFont mediumFont:17]];
        [_dateLabel setTextColor:[UIColor customTextColor]];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dateLabel];
        
        _timeLabel = [UILabel new];
        [_timeLabel setFont:[UIFont regularFont:17]];
        [_timeLabel setTextColor:[UIColor customTextColor]];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (_isTime) {
        
        CGRect frame = _dateLabel.frame;
        frame.size.height = kGeomHeightLabelInCell;
        frame.size.width = width(self);
        frame.origin.x = (width(self) - width(_dateLabel)) / 2;
        frame.origin.y = (kGeomHeightTableViewCell - kGeomHeightLabelInCell *2) /2;
        _dateLabel.frame = frame;
        
        frame = _timeLabel.frame;
        frame.size.height = 20;
        frame.size.width = width(self);
        frame.origin.x = (width(self) - width(_timeLabel)) /2;
        frame.origin.y = CGRectGetMaxY(_dateLabel.frame);
        _timeLabel.frame = frame;
    
    } else {
        
        [_dateLabel sizeToFit];
        CGRect frame = _dateLabel.frame;
        frame.origin.x = (width(self) - width(_dateLabel)) / 2;
        frame.origin.y = (height(self) - height(_dateLabel)) /2;
        _dateLabel.frame = frame;
    }
 
}

- (void)setSelected:(BOOL)selected {
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor customMainColor];
    [self setSelectedBackgroundView:bgColorView];

}

- (void)layoutCell:(BOOL)isTime {
    
    _isTime = isTime;
    __weak DateTableViewCell *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf setNeedsLayout];
    });
}

@end





