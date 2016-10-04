//
//  DatePickerView.h
//  CharterProject
//
//  Created by James Rochabrun on 9/30/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)setPickedDateString:(NSString *)datePicked;

@end

@interface DatePickerView : UIView
@property (nonatomic, strong) UIDatePicker *pickerBookingDate;
@property (nonatomic, strong) UILabel *pickerLabel;
@property (nonatomic, strong) UILabel *alertPickerLabel;
@property (nonatomic, assign) BOOL dateSatisfyMinRequiredDate;
@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;
@property (nonatomic, assign) CGFloat minRequiredHours;
@property (nonatomic, strong) NSString *localizedStartDateString;
@property (nonatomic, strong) UITableView *datesTableView;
@property (nonatomic, strong) UIButton *nextButton;
- (BOOL)isBookingDateSatisfyMinBookingTime;

@end
