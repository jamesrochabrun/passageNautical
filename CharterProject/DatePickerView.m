//
//  DatePickerView.m
//  CharterProject
//
//  Created by James Rochabrun on 9/30/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "DatePickerView.h"
#import "UIFont+CustomFont.h"
#import "UIColor+MainColor.h"
#import "Common.h"
#import "CommonUIConstants.h"
#import "NSString+DecodeHTML.h"
#import "UITableView+Additions.h"
#import "DateTableViewCell.h"

static CGFloat secondsInMinute = 60.0;
static CGFloat minuteInHour = 60.0;
NSString *const kKeyTableReuseIdentifier = @"cellReuseIdentifier";


@implementation DatePickerView

- (instancetype)init {

    self = [super init];
    if (self) {
        
        _nextButton = [UIButton new];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.titleLabel.font = [UIFont regularFont:17];
        //[_nextButton addTarget:self action:@selector(performBookSegue:) forControlEvents:UIControlEventTouchUpInside];
        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
        _nextButton.backgroundColor = [UIColor customMainColor];
        [self addSubview:_nextButton];
        
        _pickerLabel = [UILabel new];
        _pickerLabel.text = @"Check Availability";
        _pickerLabel.font = [UIFont regularFont:20];
        _pickerLabel.textColor = [UIColor customTextColor];
        _pickerLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pickerLabel];
        
        _pickerBookingDate = [[UIDatePicker alloc] init];
        _pickerBookingDate.backgroundColor = [UIColor whiteColor];
        _pickerBookingDate.tintColor = [UIColor customMainColor];
        _pickerBookingDate.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        [_pickerBookingDate addTarget:self action:@selector(userAlteredPicker:) forControlEvents:UIControlEventValueChanged];
        [_pickerBookingDate setValue:[UIColor customMainColor] forKey:@"textColor"];
        _pickerBookingDate.minimumDate = [NSDate date];
        [self addSubview:_pickerBookingDate];
        
        _alertPickerLabel = [UILabel new];
//        CGFloat minNoticeHours = [_charterService.minimumNoticeMinutes floatValue] /60;
//        _alertPickerLabel.text = [NSString stringWithFormat:@"Bookings must be with %f hours of notice", minNoticeHours];
        _alertPickerLabel.font = [UIFont regularFont:13];
        _alertPickerLabel.textColor = [UIColor alertColor];
        _alertPickerLabel.textAlignment = NSTextAlignmentCenter;
        _alertPickerLabel.hidden = YES;
        [self addSubview:_alertPickerLabel];
        
        _datesTableView = [UITableView tableViewInView:self delegate:self];
        [_datesTableView registerClass:[DateTableViewCell class] forCellReuseIdentifier:kKeyTableReuseIdentifier];
        [_datesTableView setLayoutMargins:UIEdgeInsetsZero];
        _datesTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _datesTableView.separatorColor = [UIColor customMainColor];
        _datesTableView.separatorInset = UIEdgeInsetsZero;
        _datesTableView.showsVerticalScrollIndicator = NO;
        _datesTableView.backgroundColor = [UIColor yellowColor];
        
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = _nextButton.frame;
    frame.size.height = kGeomHeightBigbutton;
    frame.size.width = width(self);
    frame.origin.x = 0;
    frame.origin.y = height(self) - kGeomHeightBigbutton;
    _nextButton.frame = frame;
    
    [_pickerLabel sizeToFit];
    frame = _pickerLabel.frame;
    frame.origin.x = (width(self) - width(_pickerLabel)) /2;
    frame.origin.y = kGeomSpaceEdge;
    _pickerLabel.frame = frame;
    
    frame = _pickerBookingDate.frame;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(_pickerLabel.frame) + kGeomMarginMedium;
    frame.size.height =  _pickerBookingDate.intrinsicContentSize.height;
    frame.size.width = width(self);
    _pickerBookingDate.frame = frame;
    
    [_alertPickerLabel sizeToFit];
    frame = _alertPickerLabel.frame;
    frame.origin.x = (width(self) - width(_alertPickerLabel)) /2;
    frame.origin.y = CGRectGetMaxY(_pickerBookingDate.frame);
    _alertPickerLabel.frame = frame;
    
    frame = _datesTableView.frame;
    frame.size.height = CGRectGetMinY(_nextButton.frame) - CGRectGetMaxY(_pickerBookingDate.frame);
    frame.size.width = width(self);
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMinY(_nextButton.frame) - frame.size.height;
    _datesTableView.frame = frame;
    
}


- (void)userAlteredPicker:(id)sender {


    if ([self isBookingDateSatisfyMinBookingTime]) {
        NSLog(@"THE DATE PICKED SATISFY THE REQUIRED GAP FOR BOOKING");
        _alertPickerLabel.hidden = YES;
        //1 now the localized start date will be used to make the get availabiliy request
        _localizedStartDateString = [NSString stringFromLocalTimeZone:_pickerBookingDate.date];
        
        //2 now we send this string to the api call
        
        //3 show the tableview with available results
        
        //4 in method selected cell perform this action and hide the DatepickerView and show the form
        [self.delegate setPickedDateString:_localizedStartDateString];


    } else {
        NSLog(@"THE DATE PICKED DON'T SATISFY THE REQUIRED GAP FOR BOOKING");
        _alertPickerLabel.hidden = NO;
    }
}

- (BOOL)isBookingDateSatisfyMinBookingTime {

    NSTimeInterval distanceBetweenDates = [_pickerBookingDate.date timeIntervalSinceDate:_pickerBookingDate.minimumDate];

    CGFloat minutesBetweenDates = distanceBetweenDates / secondsInMinute;
    CGFloat hoursBetweenDates = minutesBetweenDates / minuteInHour;

    if (ceil(hoursBetweenDates) < _minRequiredHours)
        _dateSatisfyMinRequiredDate = NO;
    else {
        _dateSatisfyMinRequiredDate = YES;
    }
    
    return _dateSatisfyMinRequiredDate;
}

- (void)setMinRequiredHours:(CGFloat)minRequiredHours {
    
    if (_minRequiredHours == minRequiredHours) return;
    _minRequiredHours = minRequiredHours / minuteInHour;
    _alertPickerLabel.text = [NSString stringWithFormat:@"Booking must be with %.f hours of notice", _minRequiredHours];;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kKeyTableReuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  5;
}




@end
