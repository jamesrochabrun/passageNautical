//
//  ViewPickerView.h
//  CharterProject
//
//  Created by James Rochabrun on 10/7/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharterService.h"
#import "PriceOptionObject.h"
@protocol ViewPickerViewDelegate <NSObject>

- (void)hideViewPickerViewAfterPriceWasSelected:(PriceOptionObject *)priceOption;

@end


@interface ViewPickerView : UIView<UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) CharterService *charterService;
@property (nonatomic, weak) id<ViewPickerViewDelegate>delegate;
@property (nonatomic, strong) PriceOptionObject *priceOption;
@end
