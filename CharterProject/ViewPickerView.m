//
//  ViewPickerView.m
//  CharterProject
//
//  Created by James Rochabrun on 10/7/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ViewPickerView.h"
#import "UIPickerView+Additions.h"
#import "Common.h"
#import "CommonUIConstants.h"
#import "PriceOptionObject.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"

@implementation ViewPickerView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = UIColorRGBOverlay(kColorOffBlack, 0.8);
        [self addSubview:_backgroundView];
        _pickerView = [UIPickerView pickerViewInView:self delegate:self];
       // _pickerView.backgroundColor = UIColorRGBA(kColorOffBlack);
        _pickerView.backgroundColor = [UIColor whiteColor];

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = _backgroundView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = height(self);
    frame.size.width = width(self);
    _backgroundView.frame = frame;
    
    frame = _pickerView.frame;
    frame.size.width = width(self);
    frame.size.height = _pickerView.intrinsicContentSize.height;
    frame.origin.x = 0;
    frame.origin.y = height(self) - frame.size.height;
    _pickerView.frame = frame;
    
}

- (void)setCharter:(CharterService *)charterService {
    
    if (_charterService == charterService) return;
    _charterService = charterService;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return _charterService.priceOptions.count;
}

//- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    
//    _priceOption = [_charterService.priceOptions objectAtIndex:row];
//    NSString *title = [NSString stringWithFormat:@"%@ %@ %@",_priceOption.priceOptionLabel , _charterService.currency, _priceOption.price];
//    return title;
//}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.view != _pickerView)
       // [self.AddView endEditing:YES];
        NSLog(@"touched");
    [self.delegate hideViewPickerViewAfterPriceWasSelected:_priceOption];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    _priceOption = [_charterService.priceOptions objectAtIndex:row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 50)];
    label.textColor = UIColorRGBA(kColorOffBlack);
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont regularFont:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%@ %@ %@",_priceOption.priceOptionLabel , _charterService.currency, _priceOption.price];
    return label;
}

@end
