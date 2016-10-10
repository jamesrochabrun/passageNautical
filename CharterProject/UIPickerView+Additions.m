//
//  UIPickerView+Additions.m
//  CharterProject
//
//  Created by James Rochabrun on 10/7/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "UIPickerView+Additions.h"

@implementation UIPickerView (Additions)

+ (UIPickerView *)pickerViewInView:(UIView *)view delegate:(id)delegate {
    
    UIPickerView *pickerView = [UIPickerView new];
    
    if (pickerView) {
        [view addSubview:pickerView];
    }
    pickerView.delegate = delegate;
    pickerView.dataSource = delegate;
    pickerView.showsSelectionIndicator = YES;
    return pickerView;
}

@end
