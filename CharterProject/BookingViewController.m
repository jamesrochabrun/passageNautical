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

@interface BookingViewController ()
@property (nonatomic, strong) TopView *topView;
@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *charterLabel;
@property (nonatomic, strong) BookingField *nameField;
@property (nonatomic, strong) BookingField *lastNameField;
@property (nonatomic, strong) BookingField *phoneField;
@property (nonatomic, strong) BookingField *mobilePhoneField;
@property (nonatomic, strong) BookingField *emailField;
@property (nonatomic, strong) BookingField *addressField;
@property (nonatomic, strong) BookingField *cityField;
@property (nonatomic, strong) BookingField *countryField;
@property (nonatomic, strong) BookingField *stateField;
@property (nonatomic, strong) BookingField *postCodeField;
@property (nonatomic, strong) NSArray *arrayOfBookingFields;
@property (nonatomic, strong) UIButton *bookButton;

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
    
    _mobilePhoneField = [[BookingField alloc] initWithLabelName:@"Mobile"];
    [_scrollView addSubview:_mobilePhoneField];
    
    _emailField = [[BookingField alloc] initWithLabelName:@"Email"];
    [_scrollView addSubview:_emailField];
    
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
    
    _arrayOfBookingFields = @[_nameField, _lastNameField, _phoneField, _mobilePhoneField, _emailField, _addressField, _cityField, _countryField, _stateField, _postCodeField];
    
    _bookButton = [UIButton new];
    [_bookButton setTitle:@"BOOK NOW" forState:UIControlStateNormal];
    [_bookButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [_bookButton addTarget:self action:@selector(bookNow) forControlEvents:UIControlEventTouchUpInside];
    _bookButton.layer.borderColor = [UIColor customMainColor].CGColor;
    _bookButton.layer.borderWidth = 2.0f;
    [_bookButton.titleLabel setFont:[UIFont mediumFont:22]];
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
    frame.size.height = height(self.view) ;
    frame.size.width = width( self.view);
    _scrollView.frame = frame;
    
    frame = _charterLabel.frame;
    frame.size.height = kGeomHeightTextField;
    frame.size.width = width(self.view) * 0.75;
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
    frame = _bookButton.frame;
    frame.size.width = kGeomWidthBigButton;
    frame.size.height = kGeomHeightBigbutton;
    frame.origin.x = (width(_scrollView) - kGeomWidthBigButton) /2;
    frame.origin.y = CGRectGetMaxY(bField.frame) + kGeomMarginMedium;
    _bookButton.frame = frame;
    
    _scrollView.contentSize = CGSizeMake(width(self.view), CGRectGetMaxY(_bookButton.frame) + kGeomBottomPadding);
    
}

- (void)dismissVC {
    
    __weak BookingViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)bookNow {
    
    //BOOK NOW
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
