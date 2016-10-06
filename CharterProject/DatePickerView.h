//
//  DatePickerView.h
//  CharterProject
//
//  Created by James Rochabrun on 9/30/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeDatePickerView.h"

@class CharterService;

@protocol DatePickerViewDelegate <NSObject>

- (void)setPickedDateStringAndShowForm:(NSString *)datePicked;
- (void)alertUserThatThereIsNoSessionForThisProduct;
- (void)alertUserThatMustSelectADateOrTime:(BOOL)boolean;
- (void)alertUserSelectAgain;

@end

@interface DatePickerView : UIView <TimeDatePickerViewDelegate>
@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;
@property (nonatomic, strong) CharterService *charterService;


- (BOOL)isBookingDateSatisfyMinBookingTime;

@end
