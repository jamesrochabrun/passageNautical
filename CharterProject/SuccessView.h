//
//  SuccessView.h
//  CharterProject
//
//  Created by James Rochabrun on 10/3/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookingObject;

@interface SuccessView : UIView
@property (nonatomic, strong) BookingObject *booking;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *orderNumber;
@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UIButton *contactButton;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *bookingCharter;
@property (nonatomic, strong) UILabel *bookingDate;
@property (nonatomic, strong) UILabel *contactLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *subTotalLabel;
@end
