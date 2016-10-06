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
- (void)alertUserThatThereIsNoSessionForThisProduct;

@end

@interface DatePickerView : UIView
@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;
@property (nonatomic, strong) UIDatePicker *pickerBookingDateStart;
@property (nonatomic, strong) UIDatePicker *pickerBookingDateEnd;
@property (nonatomic, strong) UILabel *pickerLabel;
@property (nonatomic, strong) UILabel *pickerLabelEnd;
@property (nonatomic, strong) UILabel *alertPickerLabel;
@property (nonatomic, assign) BOOL dateSatisfyMinRequiredDate;
@property (nonatomic, strong) NSString *localizedStartDateString;
@property (nonatomic, strong) UITableView *datesTableView;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) CharterService *charterService;
@property (nonatomic, strong) NSString *stringDateStart;
@property (nonatomic, strong) NSString *stringDateEnd;
@property (nonatomic, strong) UILabel *endLabelAlert;
@property (nonatomic, assign) BOOL isEndDateLater;
@property (nonatomic, strong) NSArray *sessionsArray;

- (BOOL)isBookingDateSatisfyMinBookingTime;

@end
