//
//  BookingViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 9/23/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "BookingViewController.h"
#import "CommonUIConstants.h"
#import "Common.h"
#import "BookingField.h"
#import "CharterService.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"
#import "TopView.h"
#import "CharterAPI.h"
#import "CustomerObject.h"
#import "ItemsObject.h"
#import "CommentsObject.h"
#import "PaymentsObject.h"
#import "BookingObject.h"
#import "CommentTextView.h"
#import "NSString+DecodeHTML.h"

@interface BookingViewController ()
@property (nonatomic, strong) TopView *topView;
@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *charterLabel;
@property (nonatomic, strong) BookingField *nameField;
@property (nonatomic, strong) BookingField *lastNameField;
@property (nonatomic, strong) BookingField *phoneField;
@property (nonatomic, strong) BookingField *emailField;
@property (nonatomic, strong) BookingField *companyField;
@property (nonatomic, strong) BookingField *addressField;
@property (nonatomic, strong) BookingField *cityField;
@property (nonatomic, strong) BookingField *countryField;
@property (nonatomic, strong) BookingField *stateField;
@property (nonatomic, strong) BookingField *postCodeField;
@property (nonatomic, strong) CommentTextView *commentTextView;
@property (nonatomic, strong) NSArray *arrayOfBookingFields;
@property (nonatomic, strong) UIButton *bookButton;
@property (nonatomic, strong) UIDatePicker *pickerBookingDate;
@property (nonatomic, strong) UILabel *pickerLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *alertPickerLabel;
@property CGFloat keyBoardHeight;
@property (nonatomic, strong) NSString *stringDate;
@property (nonatomic, assign) BOOL readyToBook;

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topView = [TopView new];
    _topView.delegate = self;
    [self.view addSubview:_topView];
    
    _scrollView = [UIScrollView new];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _charterLabel = [UILabel new];
    _charterLabel.text = _charterService.name;
    [_charterLabel setFont:[UIFont regularFont:15]];
    _charterLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _charterLabel.numberOfLines = 0;
    _charterLabel.textAlignment = NSTextAlignmentCenter;
    [_charterLabel setTextColor:[UIColor customMainColor]];
    [_scrollView addSubview:_charterLabel];
    
    _nameField = [[BookingField alloc] initWithLabelName:@"Name"];
    [_scrollView addSubview:_nameField];
    
    _lastNameField = [[BookingField alloc] initWithLabelName:@"Last Name"];
    [_scrollView addSubview:_lastNameField];
    
    _phoneField = [[BookingField alloc] initWithLabelName:@"Phone"];
    [_scrollView addSubview: _phoneField];
    
    _emailField = [[BookingField alloc] initWithLabelName:@"Email"];
    [_scrollView addSubview:_emailField];
    
    _companyField = [[BookingField alloc] initWithLabelName:@"Company Name"];
    [_scrollView addSubview:_companyField];
    
    _addressField = [[BookingField alloc] initWithLabelName:@"Address"];
    [_scrollView addSubview:_addressField];
    
    _cityField = [[BookingField alloc] initWithLabelName:@"City"];
    [_scrollView addSubview:_cityField];
    
    _countryField = [[BookingField alloc] initWithLabelName:@"Country"];
    [_scrollView addSubview:_countryField];
    
    _stateField = [[BookingField alloc] initWithLabelName:@"State"];
    [_scrollView addSubview: _stateField];
    
    _postCodeField = [[BookingField alloc] initWithLabelName:@"Postal Code"];
    [_scrollView addSubview:_postCodeField];
    
    _arrayOfBookingFields = @[_nameField, _lastNameField, _phoneField, _emailField, _companyField, _addressField, _cityField, _countryField, _stateField, _postCodeField];
    
    _pickerLabel = [UILabel new];
    _pickerLabel.text = @"Select a date:";
    _pickerLabel.font = [UIFont regularFont:20];
    _pickerLabel.textColor = [UIColor customTextColor];
    _pickerLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_pickerLabel];
    
    _pickerBookingDate = [[UIDatePicker alloc] init];
    _pickerBookingDate.backgroundColor = [UIColor whiteColor];
    _pickerBookingDate.tintColor = [UIColor customMainColor];
    _pickerBookingDate.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    [_pickerBookingDate addTarget:self action:@selector(userAlteredPicker:) forControlEvents:UIControlEventValueChanged];
    [_pickerBookingDate setValue:[UIColor customMainColor] forKey:@"textColor"];
    _pickerBookingDate.minimumDate = [NSDate date];
    [_scrollView addSubview:_pickerBookingDate];
    
    _alertPickerLabel = [UILabel new];
    CGFloat minNoticeHours = [_charterService.minimumNoticeMinutes floatValue] /60;
    _alertPickerLabel.text = [NSString stringWithFormat:@"Bookings must be with %f hours of notice", minNoticeHours];
    _alertPickerLabel.font = [UIFont regularFont:14];
    _alertPickerLabel.textColor = [UIColor alertColor];
    _alertPickerLabel.textAlignment = NSTextAlignmentCenter;
    _alertPickerLabel.hidden = YES;
    [_scrollView addSubview:_alertPickerLabel];
    
    _commentTextView = [[CommentTextView alloc] initWithLabelName:@"Comments:"];
    [_scrollView addSubview:_commentTextView];
    
    _bookButton = [UIButton new];
    [_bookButton setTitle:@"Book Now" forState:UIControlStateNormal];
    [_bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bookButton addTarget:self action:@selector(checkIfBookingHaveRequiredData) forControlEvents:UIControlEventTouchUpInside];
    //_bookButton.layer.borderColor = [UIColor customMainColor].CGColor;
    //_bookButton.layer.borderWidth = 2.0f;
    _bookButton.backgroundColor = [UIColor customMainColor];
    [_bookButton.titleLabel setFont:[UIFont regularFont:20]];
    [_scrollView addSubview:_bookButton];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect frame = _topView.frame;
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.origin.y = CGRectGetMinY(self.view.frame);
    frame.size.width = width(self.view);
    frame.size.height = kGeomTopViewHeight;
    _topView.frame = frame;
    
    frame = _scrollView.frame;
    frame.origin.y = CGRectGetMaxY(_topView.frame);
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.size.height = height(self.view) - _keyBoardHeight ;
    frame.size.width = width( self.view);
    _scrollView.frame = frame;
    
    frame = _charterLabel.frame;
    frame.size.height = kGeomHeightTextField;
    frame.size.width = width(self.view) * 0.85;
    frame.origin.y = CGRectGetMinY(_scrollView.frame) - kGeomTopViewHeight + kGeomMarginMedium;
    frame.origin.x = (width(self.view) - frame.size.width) /2;
    _charterLabel.frame = frame;

    CGFloat y = CGRectGetMaxY(_charterLabel.frame) + kGeomMarginMedium;
    
    for (BookingField *bField in _arrayOfBookingFields) {
        frame = bField.frame;
        frame.size.width = width(_scrollView);
        frame.size.height = 70;
        frame.origin.x = CGRectGetMinX(_scrollView.frame);
        frame.origin.y = y;
        y += frame.size.height;
        bField.frame = frame;
    }
    
    BookingField *bField = [_arrayOfBookingFields lastObject];
    
    [_pickerLabel sizeToFit];
    frame = _pickerLabel.frame;
    frame.origin.x = (width(self.view) - width(_pickerLabel)) /2;
    frame.origin.y = CGRectGetMaxY(bField.frame) + kGeomMarginBig;
    _pickerLabel.frame = frame;
    
    frame = _pickerBookingDate.frame;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(_pickerLabel.frame) + kGeomMarginMedium;
    frame.size.height =  _pickerBookingDate.intrinsicContentSize.height;
    frame.size.width = width(self.view);
    _pickerBookingDate.frame = frame;
    
    frame = _commentTextView.frame;
    frame.size.width = width(_scrollView);
    frame.size.height = kGeomHeightTextView;
    frame.origin.x = CGRectGetMinX(_scrollView.frame);
    frame.origin.y = CGRectGetMaxY(_pickerBookingDate.frame) + kGeomMarginMedium;
    _commentTextView.frame = frame;
    
    frame = _bookButton.frame;
    frame.size.width = width(self.view) * 0.8;
    frame.size.height = kGeomHeightBigbutton;
    frame.origin.x = (width(_scrollView) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_commentTextView.frame) + kGeomMarginBig;
    _bookButton.frame = frame;
    
    _scrollView.contentSize = CGSizeMake(width(self.view), CGRectGetMaxY(_bookButton.frame) + kGeomBottomPadding + kGeomMarginMedium);
    
}

//delegate methods
- (void)dismissVC {
    
    __weak BookingViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weakSelf.view endEditing:YES];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)userAlteredPicker:(id)sender {
    
    _stringDate = [NSString stringFromLocalTimeZone:_pickerBookingDate.date];
    
    if ([self isBookingDateSatisfyMinBookingTime:_pickerBookingDate.date]) {
        NSLog(@"THE DATE PICKED SATISFY THE REQUIRED GAP FOR BOOKING");
        _pickerLabel.textColor = [UIColor customTextColor];
    } else {
        
        NSLog(@"THE DATE PICKED DON'T SATISFY THE REQUIRED GAP FOR BOOKING");
    }
}

- (BOOL)isBookingDateSatisfyMinBookingTime:(NSDate *)bookingDate {
    
    NSTimeInterval distanceBetweenDates = [bookingDate timeIntervalSinceDate:_pickerBookingDate.minimumDate];
    
    CGFloat secondsInMinute = 60;
    CGFloat minuteInHour = 60;
    CGFloat minutesBetweenDates = distanceBetweenDates / secondsInMinute;
    CGFloat hoursBetweenDates = minutesBetweenDates / minuteInHour;
    
    if (ceil(hoursBetweenDates) < 48)
        return NO;
    else {
        return YES;
    }
}

-(void)checkIfBookingHaveRequiredData {
    
    for (BookingField *bookingField in _arrayOfBookingFields) {
        if ([NSString trimString:bookingField.textField.text].length <= 0 ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                bookingField.lineView.backgroundColor = [UIColor alertColor];
            });
        }
    }
    
    if ([NSString trimString:_nameField.textField.text].length > 0 &&
        [NSString trimString:_lastNameField.textField.text].length > 0 &&
        [NSString trimString:_phoneField.textField.text].length > 0 &&
        [NSString trimString:_emailField.textField.text].length > 0 &&
        [NSString trimString:_companyField.textField.text].length > 0 &&
        [NSString trimString:_addressField.textField.text].length > 0 &&
        [NSString trimString:_cityField.textField.text].length > 0 &&
        [NSString trimString:_countryField.textField.text].length > 0 &&
        [NSString trimString:_stateField.textField.text].length > 0 &&
        [NSString trimString:_postCodeField.textField.text].length > 0) {
        _readyToBook = YES;
    } else {
        _readyToBook = NO;
    }
    
    if (![self isBookingDateSatisfyMinBookingTime:_pickerBookingDate.date]) {
        
        _pickerLabel.textColor = [UIColor alertColor];
    }
    
    if (_readyToBook && [self isBookingDateSatisfyMinBookingTime:_pickerBookingDate.date]) {
       
        [self bookNow];
    } else {
        NSLog(@"SOMETHING ITS MISSING");
    }
}



- (void)bookNow {
    
    //BOOK NOW HERE GOES THE POST
    
//    NSDictionary *dict = @{ @"customer": @{
//                                    @"postCode" : @"94563",
//                                    @"state" : @"california",
//                                    @"city" : @"san francisco",
//                                    @"addressLine" : @"alameda 15",
//                                   @"companyName" : @"deemelo",
//                                   @"firstName": @"James",
//                                   @"lastName": @"Rochabrun",
//                                   @"email": @"jamesrochabrun@gmail.com",
//                                   @"phone": @"0282443060",
//                                   },
//                           @"items": @[
//                                   @{
//                                       @"productCode": @"PBEHQ0",
//                                       @"startTimeLocal": @"2016-11-07 09:00:00",
//                                       @"amount": @200,
//                                       @"quantities": @[
//                                               @{
//                                                   @"value": @"1"
//                                                   }
//                                               ]
//                                       }
//                                   ],
//                           @"comments": @"Special requirements go here",
//                            
//                           @"payments": @[
//                                   @{
//                                       @"type": @"CREDITCARD",
//                                       @"amount": @"200",
//                                       @"currency": @"USD",
//                                       @"date": @"2014-11-01T10:26:00Z",
//                                       @"label": @"Payment processed by RezdyDemoAgent"
//                                       }
//                                   ]
//                           };
    
 


    
    BookingObject *booking = [BookingObject new];
    
    booking.customer.firstName = @"james";//_nameField.textField.text;
    booking.customer.lastName = @"rochabrun";//_lastNameField.textField.text;
    booking.customer.email = @"jamesrochabrun@gmail.com";//_emailField.textField.text;
    booking.customer.phone = _phoneField.textField.text;
    booking.customer.companyName = _companyField.textField.text;
    booking.customer.postCode = _postCodeField.textField.text;
    booking.customer.state = _stateField.textField.text;
    booking.customer.city = _cityField.textField.text;
    booking.customer.addressLine = _addressField.textField.text;
    
    booking.items.amount = _charterService.advertisedPrice;
    booking.items.startTimeLocal = _stringDate;
    booking.items.quantitiesValue = @1;
    booking.items.productCode = _charterService.productCode;
    
    booking.comment.comments = _commentTextView.textView.text;
    
    booking.payment.type = @"INVOICE";
   // booking.payment.amountPayment = @"";//_charterService.advertisedPrice;
    booking.payment.currency = _charterService.currency;
    booking.payment.date = [NSString stringFromCurrentDate];
    
    NSDictionary *bookDict = [booking dictionaryFromBookingObject];
    NSLog(@"the dict is %@", bookDict);
    
//    CharterAPI *api = [CharterAPI new];
//    
//    [api sendBooking:bookDict success:^(id responseObject) {
//        
//        NSData *data = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
//        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        
//        
//        NSDictionary *requestStatus = json[@"requestStatus"];
//        
//        NSLog(@"THE RESPONSE : %@", requestStatus);
//
//        
////        NSDictionary *error = requestStatus[@"error"];
////        
////        NSString *errorMessage = error[@"errorMessage"];
//        
//        
//        //handle the response
//    } failure:^(NSURLResponse *response, NSError *error) {
//    
//    }];
}

#pragma Keyboard hide and show

- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _keyBoardHeight = kbSize.height;
    
    [self.view setNeedsLayout];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    
    [self.view setNeedsLayout];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    [UIView commitAnimations];
    _keyBoardHeight = 0.0f;
    [self.view layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
