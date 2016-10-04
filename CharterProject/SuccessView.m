//
//  SuccessView.m
//  CharterProject
//
//  Created by James Rochabrun on 10/3/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "SuccessView.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"
#import "BookingObject.h"
#import "Common.h"
#import "CommonUIConstants.h"
#import "NSString+DecodeHTML.h"


@implementation SuccessView

- (instancetype)init {
   
    self = [super init];
    if (self) {
        
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"greenLogo"];
        [_scrollView addSubview:_imageView];
        
        _textView = [UITextView new];
        _textView.scrollEnabled = NO;
        _textView.userInteractionEnabled = NO;
        [_textView setFont:[UIFont regularFont:13]];
        [_textView setTextColor:[UIColor customTextColor]];
        [_scrollView addSubview:_textView];
        
        _bookingCharter = [UILabel new];
        [_bookingCharter setFont:[UIFont regularFont:15]];
        [_bookingCharter setTextColor:[UIColor customMainColor]];
        _bookingCharter.lineBreakMode = NSLineBreakByWordWrapping;
        _bookingCharter.numberOfLines = 0;
        _bookingCharter.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:_bookingCharter];
        
        _bookingDate =[UILabel new];
        [_bookingDate setFont:[UIFont regularFont:15]];
        [_bookingDate setTextColor:[UIColor customTextColor]];
        _bookingDate.lineBreakMode = NSLineBreakByWordWrapping;
        _bookingDate.numberOfLines = 0;
        _bookingDate.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:_bookingDate];
        
        _orderNumberLabel = [UILabel new];
        _orderNumberLabel.text = @"Order Number";
        [_orderNumberLabel setFont:[UIFont regularFont:15]];
        [_orderNumberLabel setTextColor:[UIColor customTextColor]];
        [_scrollView addSubview:_orderNumberLabel];
        
        _orderNumber = [UILabel new];
        [_orderNumber setFont:[UIFont mediumFont:20]];
        [_orderNumber setTextColor:[UIColor customMainColor]];
        [_scrollView addSubview:_orderNumber];
        
        _contactLabel = [UILabel new];
        _contactLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contactLabel.numberOfLines = 0;
        _contactLabel.text = @"If you need further assistance, please contact us.";
        _contactLabel.textAlignment = NSTextAlignmentCenter;
        [_contactLabel setFont:[UIFont regularFont:14]];
        [_contactLabel setTextColor:[UIColor customTextColor]];
        [_scrollView addSubview:_contactLabel];
        
        _contactButton = [UIButton new];
        [_contactButton setTitle:@"Contact Us" forState:UIControlStateNormal];
        [_contactButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
        [_contactButton addTarget:self action:@selector(onContactButtonPressed) forControlEvents:UIControlEventTouchUpInside];
       // _mailButton.layer.borderColor = [UIColor customMainColor].CGColor;
        //_mailButton.layer.borderWidth = 2.0f;
        [_contactButton.titleLabel setFont:[UIFont mediumFont:16]];
        [_scrollView addSubview:_contactButton];
        
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = _scrollView.frame;
    frame.origin.y = 0;
    frame.origin.x = 0;
    frame.size.height = height(self);
    frame.size.width = width(self);
    _scrollView.frame = frame;
    
    frame = _imageView.frame;
    frame.size.height = 50;
    frame.size.width = 200;
    frame.origin.x = (width(self) - frame.size.width) / 2;
    frame.origin.y = kGeomMarginSmall;
    _imageView.frame = frame;
    
    frame = _textView.frame;
    frame.size.width = width(self) * 0.8;
    frame.size.height = [_textView sizeThatFits:CGSizeMake(frame.size.width, FLT_MAX)].height;
    frame.origin.y = CGRectGetMaxY(_imageView.frame) + kGeomMarginMedium;
    frame.origin.x = (width(self) - frame.size.width) /2;
    _textView.frame = frame;
    
    frame = _bookingCharter.frame;
    frame.size.height = kGeomHeightTextField;
    frame.size.width = width(_textView);
    frame.origin.y = CGRectGetMaxY(_textView.frame) + kGeomMarginSmall;
    frame.origin.x = (width(self) - frame.size.width) /2;
    _bookingCharter.frame = frame;
    
    [_bookingDate sizeToFit];
    frame = _bookingDate.frame;
    frame.origin.x = (width(self) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_bookingCharter.frame) + kGeomMarginSmall;
    _bookingDate.frame = frame;
    
    [_orderNumberLabel sizeToFit];
    frame = _orderNumberLabel.frame;
    frame.origin.x = (width(self) - width(_orderNumberLabel)) /2;
    frame.origin.y = CGRectGetMaxY(_bookingDate.frame) + kGeomMarginSmall;
    _orderNumberLabel.frame = frame;
    
    [_orderNumber sizeToFit];
    frame = _orderNumber.frame;
    frame.origin.x = (width(self) - width(_orderNumber)) /2;
    frame.origin.y = CGRectGetMaxY(_orderNumberLabel.frame) + kGeomMarginSmall;
    _orderNumber.frame = frame;
    
    frame = _contactLabel.frame;
    frame.size.height = kGeomHeightTextField;
    frame.size.width = width(_textView);
    frame.origin.x = (width(self) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_orderNumber.frame) + kGeomMarginMedium;
    _contactLabel.frame = frame;
    
    frame = _contactButton.frame;
    frame.size.height = kGeomHeightTextField;
    frame.size.width = width(_textView);
    frame.origin.x = (width(self) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_contactLabel.frame);
    _contactButton.frame = frame;

    _scrollView.contentSize = CGSizeMake(width(self), CGRectGetMaxY(_contactButton.frame) + kGeomBottomPadding + kGeomMarginMedium);

    
}

- (void)setBooking:(BookingObject *)booking {
    
    if (_booking == booking) return;
    _booking = booking;
    
    __weak SuccessView *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.textView.text = [NSString stringWithFormat:@"Dear %@ %@,\n\nThank you for your booking, below is a description of the service you booked and your order number. \nWe sent you an email to %@ with detailed information.", weakSelf.booking.customer.firstName, weakSelf.booking.customer.lastName , weakSelf.booking.customer.email];
        weakSelf.orderNumber.text = weakSelf.booking.orderNumber;
        weakSelf.bookingDate.text = [NSString stringWithFormat:@"Booking Date:\n\n%@", weakSelf.booking.items.startTimeLocal];
        weakSelf.bookingCharter.text = weakSelf.booking.items.productName;
        [weakSelf setNeedsLayout];
    });
}


- (void)onContactButtonPressed {
    
    NSLog(@"call");
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",kcontactNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        NSLog(@"not available");
    }
}








@end
