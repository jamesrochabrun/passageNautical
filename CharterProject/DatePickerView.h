//
//  DatePickerView.h
//  CharterProject
//
//  Created by James Rochabrun on 9/30/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharterService;

@protocol DatePickerViewDelegate <NSObject>

- (void)setPickedDateString:(NSString *)datePicked;

@end

@interface DatePickerView : UIView
@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;
@property (nonatomic, strong) UIDatePicker *pickerBookingDateFrom;
@property (nonatomic, strong) UIDatePicker *pickerBookingDateUntil;
@property (nonatomic, strong) UILabel *pickerLabel;
@property (nonatomic, strong) UILabel *pickerLabelUntil;
@property (nonatomic, strong) UILabel *alertPickerLabel;
@property (nonatomic, assign) BOOL dateSatisfyMinRequiredDate;
@property (nonatomic, strong) NSString *localizedStartDateString;
@property (nonatomic, strong) UITableView *datesTableView;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) CharterService *charterService;
@property (nonatomic, strong) NSString *stringDateFrom;
@property (nonatomic, strong) NSString *stringDateUntil;
@property (nonatomic, strong) UILabel *untilLabel;
@property (nonatomic, assign) BOOL isUntilDateLaterThanFromDate;

- (BOOL)isBookingDateSatisfyMinBookingTime;

@end
