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
#import "CharterAPI.h"
#import "SessionObject.h"
#import "TableHeaderView.h"
#import "TimeDatePickerView.h"

static CGFloat secondsInMinute = 60.0;
static CGFloat minuteInHour = 60.0;
NSString *const kKeyTableReuseIdentifier = @"cellReuseIdentifier";
NSString *const kKeyCheckAvailability = @"Check Availability";
NSString *const kKeySelectDate = @"Select Date";
NSString *const kKeySelectTime = @"Select Time";

@interface DatePickerView ()
@property UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIDatePicker *pickerBookingDateStart;
@property (nonatomic, strong) UIDatePicker *pickerBookingDateEnd;
@property (nonatomic, strong) TimeDatePickerView *timeDatePickerView;
@property (nonatomic, strong) UILabel *pickerLabel;
@property (nonatomic, strong) UILabel *pickerLabelEnd;
@property (nonatomic, strong) UILabel *alertPickerLabel;
@property (nonatomic, assign) BOOL dateSatisfyMinRequiredDate;
@property (nonatomic, strong) UITableView *datesTableView;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) NSString *stringDateStart;
@property (nonatomic, strong) NSString *stringDateEnd;
@property (nonatomic, strong) UILabel *endLabelAlert;
@property (nonatomic, assign) BOOL isEndDateLater;
@property (nonatomic, strong) NSArray *sessionsArray;

@property (nonatomic, strong) NSString *selectedDate;
@property (nonatomic, strong) NSString *selectedTime;

@end

@implementation DatePickerView

- (instancetype)init {

    self = [super init];
    if (self) {
        
        _nextButton = [UIButton new];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.titleLabel.font = [UIFont regularFont:17];
        [_nextButton addTarget:self action:@selector(checkAvailabilityButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_nextButton setTitle:kKeyCheckAvailability forState:UIControlStateNormal];
        _nextButton.backgroundColor = [UIColor customMainColor];
        [self addSubview:_nextButton];
        
        _pickerLabel = [UILabel new];
        _pickerLabel.text = @"Check Availability From:";
        _pickerLabel.font = [UIFont regularFont:15];
        _pickerLabel.textColor = [UIColor customTextColor];
        _pickerLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pickerLabel];
        
        _pickerBookingDateStart = [[UIDatePicker alloc] init];
        _pickerBookingDateStart.backgroundColor = [UIColor whiteColor];
        _pickerBookingDateStart.tintColor = [UIColor customMainColor];
        _pickerBookingDateStart.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        [_pickerBookingDateStart addTarget:self action:@selector(userSelectStartDate:) forControlEvents:UIControlEventValueChanged];
        [_pickerBookingDateStart setValue:[UIColor customMainColor] forKey:@"textColor"];
        _pickerBookingDateStart.minimumDate = [NSDate date];
        [self addSubview:_pickerBookingDateStart];
        
        _pickerLabelEnd = [UILabel new];
        _pickerLabelEnd.text = @"Until:";
        _pickerLabelEnd.font = [UIFont regularFont:15];
        _pickerLabelEnd.textColor = [UIColor customTextColor];
        _pickerLabelEnd.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pickerLabelEnd];
        
        _pickerBookingDateEnd = [[UIDatePicker alloc] init];
        _pickerBookingDateEnd.backgroundColor = [UIColor whiteColor];
        _pickerBookingDateEnd.tintColor = [UIColor customMainColor];
        _pickerBookingDateEnd.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        [_pickerBookingDateEnd addTarget:self action:@selector(userSelectEndDate:) forControlEvents:UIControlEventValueChanged];
        [_pickerBookingDateEnd setValue:[UIColor customMainColor] forKey:@"textColor"];
        _pickerBookingDateEnd.minimumDate = [NSDate date];
        [self addSubview:_pickerBookingDateEnd];
        
        _alertPickerLabel = [UILabel new];
        _alertPickerLabel.font = [UIFont regularFont:13];
        _alertPickerLabel.textColor = [UIColor alertColor];
        _alertPickerLabel.textAlignment = NSTextAlignmentCenter;
        _alertPickerLabel.hidden = YES;
       // _alertPickerLabel.text = @"tests";
        [self addSubview:_alertPickerLabel];
        
        _endLabelAlert = [UILabel new];
        _endLabelAlert.font = [UIFont regularFont:13];
        _endLabelAlert.textColor = [UIColor alertColor];
        _endLabelAlert.textAlignment = NSTextAlignmentCenter;
        _endLabelAlert.hidden = YES;
        _endLabelAlert.text = @"please choose a later date";
        [self addSubview:_endLabelAlert];
        
        _datesTableView = [UITableView tableViewInView:self delegate:self];
        [_datesTableView registerClass:[DateTableViewCell class] forCellReuseIdentifier:kKeyTableReuseIdentifier];
        [_datesTableView setLayoutMargins:UIEdgeInsetsZero];
        _datesTableView.separatorColor = [UIColor customMainColor];
        _datesTableView.separatorInset = UIEdgeInsetsZero;
        _datesTableView.showsVerticalScrollIndicator = NO;
        _datesTableView.hidden = YES;
        
        _timeDatePickerView = [TimeDatePickerView new];
        _timeDatePickerView.delegate = self;
        _timeDatePickerView.hidden = YES;
        [self addSubview:_timeDatePickerView];
        
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
    frame.origin.y = (IS_IPHONE4)? kGeomMarginSmall: kGeomMarginBig;
    _pickerLabel.frame = frame;
    
    [_alertPickerLabel sizeToFit];
    frame = _alertPickerLabel.frame;
    frame.origin.x = (width(self) - width(_alertPickerLabel)) /2;
    frame.origin.y = CGRectGetMaxY(_pickerLabel.frame) + kGeomSpaceEdge;
    _alertPickerLabel.frame = frame;
    
    frame = _pickerBookingDateStart.frame;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(_pickerLabel.frame);
    frame.size.height = dynamicHeightOfDatePicker;
    frame.size.width = width(self);
    _pickerBookingDateStart.frame = frame;
    
    [_pickerLabelEnd sizeToFit];
    frame = _pickerLabelEnd.frame;
    frame.origin.x = (width(self) - width(_pickerLabelEnd)) /2;
    frame.origin.y = CGRectGetMaxY(_pickerBookingDateStart.frame) + kGeomSpaceEdge;
    _pickerLabelEnd.frame = frame;
    
    [_endLabelAlert sizeToFit];
    frame = _endLabelAlert.frame;
    frame.origin.x = (width(self) - width(_endLabelAlert)) /2;
    frame.origin.y = CGRectGetMaxY(_pickerLabelEnd.frame) + kGeomSpaceEdge;
    _endLabelAlert.frame = frame;
    
    frame = _pickerBookingDateEnd.frame;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(_pickerLabelEnd.frame);
    frame.size.height = dynamicHeightOfDatePicker;
    frame.size.width = width(self);
    _pickerBookingDateEnd.frame = frame;
    
    frame = _datesTableView.frame;
    frame.size.height = height(self) - kGeomHeightBigbutton;
    frame.size.width = width(self);
    frame.origin.x = 0;
    frame.origin.y = 0;
    _datesTableView.frame = frame;
    
    frame = _timeDatePickerView.frame;
    frame.size.height = 300;;
    frame.size.width = width(self);
    frame.origin.x = 0;
    frame.origin.y = (height(self) - 300) /2;
    _timeDatePickerView.frame = frame;
}

- (void)startActivityIndicator {
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:_activityIndicator];
    _activityIndicator.center = CGPointMake(width(self) /2,height(self) /2);
    __weak DatePickerView *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.activityIndicator startAnimating];
    });
}

- (void)userSelectStartDate:(id)sender {
    
    if ([self isBookingDateSatisfyMinBookingTime]) {
        
        NSLog(@"THE DATE PICKED SATISFY THE REQUIRED GAP FOR BOOKING");
        _alertPickerLabel.hidden = YES;
       _stringDateStart = [NSString stringFromLocalTimeZone:_pickerBookingDateStart.date];
        NSLog(@"the _stringDateStart is %@", _stringDateStart);
        NSLog(@"the _pickerBokingDateStart is %@", _pickerBookingDateStart.date);

    } else {
        NSLog(@"THE DATE PICKED DON'T SATISFY THE REQUIRED GAP FOR BOOKING");
        _alertPickerLabel.hidden = NO;
    }
}

- (void)userSelectEndDate:(id)sender {
    
    if ([self isEndDateLaterThanStartDate]) {
        _stringDateEnd = [NSString stringFromLocalTimeZone:_pickerBookingDateEnd.date];
        _endLabelAlert.hidden = YES;
        NSLog(@"the _stringDateEnd is %@", _stringDateEnd);
        NSLog(@"the pickerBookingDateEnd is %@", _pickerBookingDateEnd.date);

    } else {
        _endLabelAlert.hidden = NO;
        
    }
}

- (void)checkAvailabilityButtonPressed {
    
    if ([_nextButton.titleLabel.text isEqualToString:kKeyCheckAvailability]) {
        if (![self isBookingDateSatisfyMinBookingTime]) {
            _alertPickerLabel.hidden = NO;
        }
        
        if ([self isEndDateLaterThanStartDate]) {
            _endLabelAlert.hidden = YES;
        } else {
            _endLabelAlert.hidden = NO;
        }
        
        if ([self isBookingDateSatisfyMinBookingTime] &&
            [self isEndDateLaterThanStartDate]) {
            NSLog(@"YES LETS GO!");
            [self checkAvailabilityForService];
        } else {
            NSLog(@"NO DUDE SOMETHING IS MISSING");
        }
    } else if ([_nextButton.titleLabel.text isEqualToString:kKeySelectDate]) {
       
        if (_selectedDate) {
            
            if ([_charterService.bookingMode isEqualToString:kKeyBookingModeInventory]) {
                
                [self.delegate setPickedDateStringAndShowForm:_selectedDate];
                
            } else if ([_charterService.bookingMode isEqualToString:kKeyBookingModeDateEnquiry]) {
                
                NSLog(@"type: %@ so show the timepicker", _charterService.bookingMode);
                
                __weak DatePickerView *weakSelf = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.timeDatePickerView.alpha = 0;
                    weakSelf.datesTableView.hidden = YES;
                    [UIView animateWithDuration:.5 animations:^{
                        weakSelf.timeDatePickerView.hidden = NO;
                        weakSelf.timeDatePickerView.alpha = 1;
                    }];
                    weakSelf.pickerBookingDateStart.hidden = YES;
                    weakSelf.pickerBookingDateEnd.hidden = YES;
                    weakSelf.pickerLabel.hidden = YES;
                    weakSelf.pickerLabelEnd.hidden = YES;
                    [weakSelf.nextButton setTitle:kKeySelectTime forState:UIControlStateNormal];
                });
            }
        } else {
            //alert user pick a date
            [self.delegate alertUserThatMustSelectADateOrTime:NO];
        }
    } else if ([_nextButton.titleLabel.text isEqualToString:kKeySelectTime]) {
        //show date picker for time and pass the hour and construct a string with a date and a time;
        if (_selectedTime) {
            
            NSLog(@"the selected date %@", _selectedDate);
            NSLog(@"the selected time before the format %@", _selectedTime);
            _selectedTime = [_timeDatePickerView fullStringFromStartDate:_selectedDate];
            NSLog(@"the selected time after the format %@", _selectedTime);
            [self.delegate setPickedDateStringAndShowForm:_selectedTime];

        } else {
            NSLog(@"please select a time");
            [self.delegate alertUserThatMustSelectADateOrTime:YES];

        }
    }
}
- (void)setPickedTimeString:(NSString *)timePicked {
    
    _selectedTime = timePicked;
    NSLog(@"the selectedTime in delegate %@", _selectedTime);
}

- (void)checkAvailabilityForService {
    
    //here we can put an alert just in case
    if (!_stringDateStart || !_stringDateEnd) {
        [self.delegate alertUserSelectAgain];
        return;
    };
    
    [self startActivityIndicator];
    
    [CharterAPI checkAvailabilityForProduct:_charterService from:_stringDateStart until:_stringDateEnd success:^(NSArray *sessions) {
        
        for (SessionObject *session in sessions) {
            NSLog(@"the session.productCode is %@", session.productCode);
        }
        
        if (sessions.count) {
            _sessionsArray = sessions;
            
            __weak DatePickerView *weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.datesTableView reloadData];
                weakSelf.datesTableView.alpha = 0;

                [UIView animateWithDuration:.5 animations:^{
                    weakSelf.datesTableView.hidden = NO;
                    weakSelf.datesTableView.alpha = 1;
                }];
                
                [weakSelf.activityIndicator stopAnimating];
                [weakSelf.nextButton setTitle:kKeySelectDate forState:UIControlStateNormal];
            });
            
        } else {
            NSLog(@"NO SESSIONS FOUNDED");
            [_activityIndicator stopAnimating];
            [self noSessionFounded];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"the operation is %@, the error is %@", operation, error);
    }];
}

- (void)noSessionFounded {
    [self.delegate alertUserThatThereIsNoSessionForThisProduct];
}

- (BOOL)isEndDateLaterThanStartDate {
    
    if ([_pickerBookingDateEnd.date isEarlierThanOrEqualTo:_pickerBookingDateStart.date]) {
       
        _isEndDateLater = NO;
    } else {
        _isEndDateLater = YES;
    }
    return _isEndDateLater;
}


- (BOOL)isBookingDateSatisfyMinBookingTime {

    NSTimeInterval distanceBetweenDates = [_pickerBookingDateStart.date timeIntervalSinceDate:_pickerBookingDateStart.minimumDate];

    CGFloat minutesBetweenDates = distanceBetweenDates / secondsInMinute;
    CGFloat hoursBetweenDates = minutesBetweenDates / minuteInHour;
    CGFloat minRequiredHours =  [_charterService.minimumNoticeMinutes intValue] / minuteInHour;

    if (floor(hoursBetweenDates) < minRequiredHours || !_pickerBookingDateStart.date)
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
        [weakSelf setNeedsLayout];
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kKeyTableReuseIdentifier forIndexPath:indexPath];
    SessionObject *session = [_sessionsArray objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = [NSString stringDateFromLocalTimeZone:session.startTimeLocal];

    if ([_charterService.bookingMode isEqualToString:kKeyBookingModeInventory]) {
        cell.timeLabel.text = [NSString stringHourFromLocalTimeZone:session.startTimeLocal];
        [cell layoutCell:YES];
    }
    
    cell.dateLabel.highlightedTextColor = [UIColor whiteColor];
    cell.timeLabel.highlightedTextColor = [UIColor whiteColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _sessionsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return  kGeomHeightTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DateTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SessionObject *session = [_sessionsArray objectAtIndex:indexPath.row];
    _selectedDate = session.startTimeLocal;
    cell.selected = YES;
}
   
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  kGeomHeightHeaderView;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    TableHeaderView *header = [[TableHeaderView alloc] initWithHeaderTitle:@"Select a date"];
    return header;
    
}




@end
