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
#import "DatePickerView.h"
#import "SuccessView.h"

static NSString *kKeyBooking = @"booking";
static NSString *kKeyRequestStatus = @"requestStatus";
static NSString *kKeySuccess = @"success";
static NSString *kKeyError = @"error";
static NSString *kKeyErrorMessage = @"errorMessage";

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
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) DatePickerView *datePickerView;
@property CGFloat keyBoardHeight;
@property (nonatomic, strong) NSString *stringDate;
@property (nonatomic, assign) BOOL readyToBook;
@property (nonatomic, strong) SuccessView *succesView;

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topView = [TopView new];
    _topView.delegate = self;
    [self.view addSubview:_topView];
    
    _succesView = [SuccessView new];
    _succesView.hidden = YES;
    [self.view addSubview:_succesView];
    
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
    _phoneField.textField.keyboardType = UIKeyboardTypePhonePad;
    [_scrollView addSubview: _phoneField];
    
    _emailField = [[BookingField alloc] initWithLabelName:@"Email"];
    _emailField.textField.keyboardType = UIKeyboardTypeEmailAddress;
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
  
    _datePickerView = [DatePickerView new];
    _datePickerView.minRequiredHours = [_charterService.minimumNoticeMinutes intValue];
    _datePickerView.delegate = self;
    [_scrollView addSubview:_datePickerView];
    
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
    
    //[self creatinganobject];

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
    
    frame = _datePickerView.frame;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(bField.frame) + kGeomMarginMedium;
    frame.size.height =  _datePickerView.pickerBookingDate.intrinsicContentSize.height + kGeomMarginBig;
    frame.size.width = width(self.view);
    _datePickerView.frame = frame;
    
    frame = _commentTextView.frame;
    frame.size.width = width(_scrollView);
    frame.size.height = kGeomHeightTextView;
    frame.origin.x = CGRectGetMinX(_scrollView.frame);
    frame.origin.y = CGRectGetMaxY(_datePickerView.frame) + kGeomMarginMedium;
    _commentTextView.frame = frame;
    
    frame = _bookButton.frame;
    frame.size.width = width(self.view) * 0.8;
    frame.size.height = kGeomHeightBigbutton;
    frame.origin.x = (width(_scrollView) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_commentTextView.frame) + kGeomMarginBig;
    _bookButton.frame = frame;
    
    _scrollView.contentSize = CGSizeMake(width(self.view), CGRectGetMaxY(_bookButton.frame) + kGeomBottomPadding + kGeomMarginMedium);
    
    frame = _succesView.frame;
    frame.origin.y = CGRectGetMaxY(_topView.frame);
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.size.height = height(self.view);
    frame.size.width = width( self.view);
    _succesView.frame = frame;
    
}

//delegate methods
- (void)dismissVC {
    
    __weak BookingViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weakSelf.view endEditing:YES];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)setPickedDateString:(NSString *)datePicked {
    
    _stringDate = datePicked;
    NSLog(@"the date in delegate is %@", _stringDate);
    
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
    
    if ([_datePickerView isBookingDateSatisfyMinBookingTime]) {
        _datePickerView.alertPickerLabel.hidden = YES;
    } else {
        _datePickerView.alertPickerLabel.hidden = NO;
    }
    
    if (_readyToBook && [_datePickerView isBookingDateSatisfyMinBookingTime]) {
       
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
    booking.customer.email = @"jamesrochabrun@gmail.com";/// _emailField.textField.text;
    booking.customer.phone = _phoneField.textField.text;
    booking.customer.companyName = _companyField.textField.text;
    booking.customer.postCode = _postCodeField.textField.text;
    booking.customer.state = _stateField.textField.text;
    booking.customer.city = _cityField.textField.text;
    booking.customer.addressLine = _addressField.textField.text;
    
    booking.items.amount = _charterService.advertisedPrice;
    booking.items.startTimeLocal = _stringDate;
    
    NSLog(@"the string date inside the booking is %@", _stringDate);
    booking.items.quantitiesValue = @1;
    booking.items.productCode = _charterService.productCode;
    
    booking.comment.comments = _commentTextView.textView.text;
    
    booking.payment.type = @"INVOICE";
    // booking.payment.amountPayment = @"";//_charterService.advertisedPrice;
    booking.payment.currency = _charterService.currency;
    booking.payment.date = [NSString stringFromCurrentDate];
    
    NSDictionary *bookDict = [booking dictionaryFromBookingObject];
    NSLog(@"the dict is %@", bookDict);
    
    CharterAPI *api = [CharterAPI new];
    
    [api sendBooking:bookDict success:^(id responseObject) {
        
        NSDictionary *booking = responseObject[kKeyBooking];
        NSDictionary *requestStatus  = responseObject[kKeyRequestStatus];
        NSNumber *success = requestStatus[kKeySuccess];
        
        NSLog(@"THE RESPONSEOBJECT IS %@", responseObject);
        
        if ([success isEqual:@1]) {
            [self handleSuccessBooking:booking];
        } else if ([success isEqual:@0] || [requestStatus objectForKey:@"error"]) {
            [self handleErrorOnBooking:requestStatus];
        }
    }];
}

- (void)handleSuccessBooking:(NSDictionary *)booking  {
    
    __weak BookingViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.scrollView.hidden = YES;
        weakSelf.succesView.hidden = NO;
    });

    BookingObject *bookingObject = [BookingObject bookingFromDict:booking];
    _succesView.booking = bookingObject;
}

- (void)handleErrorOnBooking:(NSDictionary *)requestStatus {
    
    NSDictionary *error = requestStatus[kKeyError];
    NSString *errorMessage = error[kKeyErrorMessage];
    
    UIAlertController *alertSaved = [UIAlertController alertControllerWithTitle:@"Something went wrong :(" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    __weak BookingViewController *weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf presentViewController:alertSaved animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertSaved dismissViewControllerAnimated:YES completion:nil];
        });
    });

}








- (void)creatinganobject {
    
    NSDictionary *response = @{
        @"booking" :   @{
                           @"comments" : @"estos son los comments",
                           @"customer" :        @{
                               @"addressLine" : @"Dfvdfbd",
                               @"city" : @"Dfvdfbd",
                @"companyName" : @"Fed",
                               @"email" : @"jamesrochabrun@gmail.com",
                @"firstName" : @"james",
                               @"id" : @3544254,
                               @"lastName" : @"rochabrun",
                               @"name" : @"james rochabrun",
                               @"phone" : @555,
                               @"postCode" : @"Fvdfv",
                               @"state" : @"Fdefdfvdd",
            },
                           @"dateConfirmed" : @"2016-10-01T04:31:14.542Z",
                           @"dateCreated" : @"2016-10-01T04:31:14.542Z",
                           @"fields" :       @[
                              @{
                                  @"label" : @"PNE Rep",
                                  @"requiredPerBooking" : @0,
                                  @"requiredPerParticipant" : @0,
                              },
                              @{
                                  @"label" : @"Referrer",
                                  @"requiredPerBooking" : @0,
                                  @"requiredPerParticipant" : @0,
                              }
                              ],
                           @"items" :         @[
                             @{
                                 @"amount" : @350,
                                 @"extras" :                 @[
                                 ],
                                 @"participants" :                 @[
                                 ],
                                 @"productCode" : @"PVEQHJ",
                                 @"productName" : @"Naultical Overnight - Sail: Oceanis 35 - Overnight Only",
                                 @"quantities"    :              @[
                                                               @{
                                                                   @"optionLabel" : @"Nautical Overnight",
                                                                   @"optionPrice" : @350,
                                                                   @"value" : @1,
                                                               }
                                                               ],
                                 @"startTime" : @"2016-10-04T04:30:00Z",
                                 @"startTimeLocal" : @"2016-10-03 21:30:00",
                                 @"subtotal" : @350,
                                 @"totalQuantity" : @1,
                                 @"vouchers" :                @[
                                 ],
                             }
                             ],
                           @"orderNumber" : @"RDJV2NC",
                           @"payments" : @[
                                @{
                                    @"amount" : @0,
                                    @"currency" : @"USD",
                                    @"date" : @"2016-09-30T21:31:14Z",
                                    @"label" : @"",
                                    @"type" : @"INVOICE",
                                }
                                ],
                           @"source" : @"API",
                           @"status" : @"CONFIRMED",
                           @"supplierId" : @29503,
                           @"supplierName" : @"Passage Nautical - On The Water Experiences",
                           @"totalAmount" : @350,
                           @"totalCurrency" : @"USD",
                           @"totalDue" :  @350,
                           @"totalPaid" : @0,
                           @"vouchers" : @[
            ],
        },
        @"requestStatus" :     @{
                                 @"success" : @1,
                                 @"version" : @"v1",
        },
    };

    NSDictionary *booking = response[kKeyBooking];

    BookingObject *boo = [BookingObject bookingFromDict:booking];
    
    NSLog(@"the name is %@" , boo.customer.firstName);
    NSLog(@"the name is %@" , boo.customer.lastName);
    NSLog(@"the name is %@" , boo.customer.addressLine);
    NSLog(@"the name is %@" , boo.orderNumber);
    NSLog(@"the name is %@" , boo.dateConfirmed);
    NSLog(@"the name is %@" , boo.items.productCode);
    NSLog(@"the name is %@" , boo.items.productName);
    NSLog(@"the name is %@" , boo.payment.amountPayment);
    NSLog(@"the name is %@" , boo.payment.currency);
    NSLog(@"the name is %@" , boo.payment.type);
    NSLog(@"the name is %@" , boo.items.startTimeLocal);
    
    [self handleSuccessBooking:booking];
    
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
