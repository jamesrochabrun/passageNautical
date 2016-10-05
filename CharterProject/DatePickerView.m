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
#import "CommonUIConstants.h"
#import "CharterService.h"
#import "NSDate+Adittions.h"

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
        [_nextButton addTarget:self action:@selector(checkAvailability) forControlEvents:UIControlEventTouchUpInside];
        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
        _nextButton.backgroundColor = [UIColor customMainColor];
        [self addSubview:_nextButton];
        
        _pickerLabel = [UILabel new];
        _pickerLabel.text = @"Check Availability From:";
        _pickerLabel.font = [UIFont regularFont:15];
        _pickerLabel.textColor = [UIColor customTextColor];
        _pickerLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pickerLabel];
        
        _pickerBookingDateFrom = [[UIDatePicker alloc] init];
        _pickerBookingDateFrom.backgroundColor = [UIColor whiteColor];
        _pickerBookingDateFrom.tintColor = [UIColor customMainColor];
        _pickerBookingDateFrom.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        [_pickerBookingDateFrom addTarget:self action:@selector(userSelectFromDate:) forControlEvents:UIControlEventValueChanged];
        [_pickerBookingDateFrom setValue:[UIColor customMainColor] forKey:@"textColor"];
        _pickerBookingDateFrom.minimumDate = [NSDate date];
        [self addSubview:_pickerBookingDateFrom];
        
        _pickerLabelUntil = [UILabel new];
        _pickerLabelUntil.text = @"Until:";
        _pickerLabelUntil.font = [UIFont regularFont:15];
        _pickerLabelUntil.textColor = [UIColor customTextColor];
        _pickerLabelUntil.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pickerLabelUntil];
        
        _pickerBookingDateUntil = [[UIDatePicker alloc] init];
        _pickerBookingDateUntil.backgroundColor = [UIColor whiteColor];
        _pickerBookingDateUntil.tintColor = [UIColor customMainColor];
        _pickerBookingDateUntil.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        [_pickerBookingDateUntil addTarget:self action:@selector(userSelectUntilDate:) forControlEvents:UIControlEventValueChanged];
        [_pickerBookingDateUntil setValue:[UIColor customMainColor] forKey:@"textColor"];
        _pickerBookingDateUntil.minimumDate = [NSDate date];
        [self addSubview:_pickerBookingDateUntil];
        
        _alertPickerLabel = [UILabel new];
        _alertPickerLabel.font = [UIFont regularFont:13];
        _alertPickerLabel.textColor = [UIColor alertColor];
        _alertPickerLabel.textAlignment = NSTextAlignmentCenter;
        _alertPickerLabel.hidden = YES;
        [self addSubview:_alertPickerLabel];
        
        _untilLabel = [UILabel new];
        _untilLabel.font = [UIFont regularFont:13];
        _untilLabel.textColor = [UIColor alertColor];
        _untilLabel.textAlignment = NSTextAlignmentCenter;
        _untilLabel.hidden = YES;
        _untilLabel.text = @"please choose a later date";
        [self addSubview:_untilLabel];
        
        _datesTableView = [UITableView tableViewInView:self delegate:self];
        [_datesTableView registerClass:[DateTableViewCell class] forCellReuseIdentifier:kKeyTableReuseIdentifier];
        [_datesTableView setLayoutMargins:UIEdgeInsetsZero];
        _datesTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _datesTableView.separatorColor = [UIColor customMainColor];
        _datesTableView.separatorInset = UIEdgeInsetsZero;
        _datesTableView.showsVerticalScrollIndicator = NO;
        _datesTableView.backgroundColor = [UIColor yellowColor];
        _datesTableView.hidden = YES;
        
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat totalHeightOfView = height(self);
    CGFloat dynamicHeightOfDatePicker = totalHeightOfView / 3;

    CGRect frame = _nextButton.frame;
    frame.size.height = kGeomHeightBigbutton;
    frame.size.width = width(self);
    frame.origin.x = 0;
    frame.origin.y = height(self) - kGeomHeightBigbutton;
    _nextButton.frame = frame;
    
    [_pickerLabel sizeToFit];
    frame = _pickerLabel.frame;
    frame.origin.x = (width(self) - width(_pickerLabel)) /2;
    frame.origin.y =  (IS_IPHONE4)? kGeomMarginSmall: kGeomMarginBig;
    _pickerLabel.frame = frame;
    
    [_alertPickerLabel sizeToFit];
    frame = _alertPickerLabel.frame;
    frame.origin.x = (width(self) - width(_alertPickerLabel)) /2;
    frame.origin.y = CGRectGetMaxY(_pickerLabel.frame) + kGeomSpaceEdge;
    _alertPickerLabel.frame = frame;
    
    frame = _pickerBookingDateFrom.frame;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(_pickerLabel.frame);
    frame.size.height = dynamicHeightOfDatePicker;
    frame.size.width = width(self);
    _pickerBookingDateFrom.frame = frame;
    
    [_pickerLabelUntil sizeToFit];
    frame = _pickerLabelUntil.frame;
    frame.origin.x = (width(self) - width(_pickerLabelUntil)) /2;
    frame.origin.y = CGRectGetMaxY(_pickerBookingDateFrom.frame) + kGeomSpaceEdge;
    _pickerLabelUntil.frame = frame;
    
    [_untilLabel sizeToFit];
    frame = _untilLabel.frame;
    frame.origin.x = (width(self) - width(_untilLabel)) /2;
    frame.origin.y = CGRectGetMaxY(_pickerLabelUntil.frame) + kGeomSpaceEdge;
    _untilLabel.frame = frame;
    
    frame = _pickerBookingDateUntil.frame;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(_pickerLabelUntil.frame);
    frame.size.height = dynamicHeightOfDatePicker;
    frame.size.width = width(self);
    _pickerBookingDateUntil.frame = frame;
    
    frame = _datesTableView.frame;
    frame.size.height = height(self) - kGeomHeightBigbutton;
    frame.size.width = width(self);
    frame.origin.x = 0;
    frame.origin.y = 0;
    _datesTableView.frame = frame;
}

- (void)userSelectFromDate:(id)sender {
    
    if ([self isBookingDateSatisfyMinBookingTime]) {
        
        NSLog(@"THE DATE PICKED SATISFY THE REQUIRED GAP FOR BOOKING");
        _alertPickerLabel.hidden = YES;
       _stringDateFrom = [NSString stringFromLocalTimeZone:_pickerBookingDateFrom.date];
       NSLog(@"the stringDateFrom is %@", _stringDateFrom);
    } else {
        NSLog(@"THE DATE PICKED DON'T SATISFY THE REQUIRED GAP FOR BOOKING");
        _alertPickerLabel.hidden = NO;
    }
}

- (void)userSelectUntilDate:(id)sender {
    
    _stringDateUntil = [NSString stringFromLocalTimeZone:_pickerBookingDateUntil.date];
    
    if ([self isUntilDateLaterThanFromDate]) {
        _untilLabel.hidden = YES;
    } else {
        _untilLabel.hidden = NO;
        
    }
    
}

- (void)checkAvailability {
    
    NSLog(@"the fromstring %@", _stringDateFrom);
    NSLog(@"the until string %@" , _stringDateUntil);
    
    if (![self isBookingDateSatisfyMinBookingTime]) {
        _alertPickerLabel.hidden = NO;
    }
    
    if ([self isUntilDateLaterThanFromDate]) {
        _untilLabel.hidden = YES;
    } else {
        _untilLabel.hidden = NO;
    }
    
    if ([self isBookingDateSatisfyMinBookingTime] &&
        [self isUntilDateLaterThanFromDate]) {
        //send strings to the server
    }
    
}

- (BOOL)isUntilDateLaterThanFromDate {
    
    if (!_pickerBookingDateUntil.date ||
        [_pickerBookingDateUntil.date isEarlierThanOrEqualTo:_pickerBookingDateFrom.date]) {
       
        _isUntilDateLaterThanFromDate = NO;
    } else {
        _isUntilDateLaterThanFromDate = YES;
    }
    
    return _isUntilDateLaterThanFromDate;
}


//this is the one for BOOKKKKK
- (void)userAlteredPicker:(id)sender {


    if ([self isBookingDateSatisfyMinBookingTime]) {
        NSLog(@"THE DATE PICKED SATISFY THE REQUIRED GAP FOR BOOKING");
        _alertPickerLabel.hidden = YES;
        //1 now the localized start date will be used to make the get availabiliy request
        _localizedStartDateString = [NSString stringFromLocalTimeZone:_pickerBookingDateFrom.date];
        
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

    NSTimeInterval distanceBetweenDates = [_pickerBookingDateFrom.date timeIntervalSinceDate:_pickerBookingDateFrom.minimumDate];

    CGFloat minutesBetweenDates = distanceBetweenDates / secondsInMinute;
    CGFloat hoursBetweenDates = minutesBetweenDates / minuteInHour;
    CGFloat minRequiredHours =  [_charterService.minimumNoticeMinutes intValue] / minuteInHour;

    if (floor(hoursBetweenDates) < minRequiredHours)
        _dateSatisfyMinRequiredDate = NO;
    else {
        _dateSatisfyMinRequiredDate = YES;
    }
    
    return _dateSatisfyMinRequiredDate;
}



- (void)setCharterService:(CharterService *)charterService {
    
    if (_charterService == charterService) return;
    _charterService = charterService;
    
    CGFloat minRequiredHours = [charterService.minimumNoticeMinutes intValue] / minuteInHour;

    __weak DatePickerView *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.alertPickerLabel.text = [NSString stringWithFormat:@"Booking must be with %.f hours of notice", minRequiredHours];;
    });
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
