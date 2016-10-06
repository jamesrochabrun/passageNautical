//
//  TimeDatePickerView.h
//  CharterProject
//
//  Created by James Rochabrun on 10/6/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TimeDatePickerViewDelegate <NSObject>

- (void)setPickedTimeString:(NSString *)timePicked;

@end


@interface TimeDatePickerView : UIView
@property (nonatomic, weak) id<TimeDatePickerViewDelegate> delegate;

- (NSString *)fullStringFromStartDate:(NSString *)stringDate;


@end
