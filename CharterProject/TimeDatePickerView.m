//
//  TimeDatePickerView.m
//  CharterProject
//
//  Created by James Rochabrun on 10/6/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "TimeDatePickerView.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"
#import "Common.h"
#import "CommonUIConstants.h"
#import "NSString+DecodeHTML.h"

@interface TimeDatePickerView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIDatePicker *timePicker;
@property (nonatomic, strong) NSString *selectedTime;

@end

@implementation TimeDatePickerView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"Select time";
        _titleLabel.font = [UIFont regularFont:18];
        _titleLabel.textColor = [UIColor customMainColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _timePicker = [[UIDatePicker alloc] init];
        _timePicker.backgroundColor = [UIColor whiteColor];
        _timePicker.tintColor = [UIColor customMainColor];
        _timePicker.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        [_timePicker addTarget:self action:@selector(userSelectTime:) forControlEvents:UIControlEventValueChanged];
        [_timePicker setValue:[UIColor customMainColor] forKey:@"textColor"];
        _timePicker.minimumDate = [NSDate date];
        _timePicker.datePickerMode = UIDatePickerModeTime;
        [self addSubview:_timePicker];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    CGRect frame = _titleLabel.frame;
    frame.origin.x = (width(self) - width(_titleLabel)) /2;
    frame.origin.y = 0;
    _titleLabel.frame = frame;
    
    frame = _timePicker.frame;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(_titleLabel.frame);
    frame.size.height = _timePicker.intrinsicContentSize.height;
    frame.size.width = width(self);
    _timePicker.frame = frame;
}

- (NSString *)fullStringFromStartDate:(NSString *)selectedDate {
    
    NSString *fullStr;
    if (_selectedTime) {
        
      NSString *date = [NSString stringDateFromLocalTimeZone:selectedDate];
      NSString *time = [NSString stringHourFromLocalTimeZone:_selectedTime];
        
        fullStr = [NSString stringWithFormat:@"%@ %@", date, time];
      
    } else {
        //handle it
        NSLog(@"selected time is null == %@", _selectedTime);
    }
    return fullStr;
}

- (void)userSelectTime:(id)sender {
    
    _selectedTime = [NSString stringFromLocalTimeZone:_timePicker.date];
    
    [self.delegate setPickedTimeString:_selectedTime];

}

@end
