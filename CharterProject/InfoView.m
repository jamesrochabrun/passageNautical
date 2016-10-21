//
//  InfoView.m
//  CharterProject
//
//  Created by James Rochabrun on 10/3/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "InfoView.h"
#import "UIFont+CustomFont.h"
#import "UIColor+MainColor.h"
#import "Common.h"
#import "CommonUIConstants.h"
#import "CharterService.h"
#import <CoreLocation/CoreLocation.h>


@implementation InfoView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _numberOFpeopleLabel = [UILabel new];
        _numberOFpeopleLabel.font = [UIFont regularFont:16];
        _numberOFpeopleLabel.textColor = [UIColor customTextColor];
        _numberOFpeopleLabel.textAlignment = NSTextAlignmentCenter;
        _numberOFpeopleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _numberOFpeopleLabel.numberOfLines = 0;
        _numberOFpeopleLabel.alpha = 0;
        [self addSubview:_numberOFpeopleLabel];
        
        _durationHoursLabel = [UILabel new];
        _durationHoursLabel.font = [UIFont regularFont:16];
        _durationHoursLabel.textColor = [UIColor customTextColor];
        _durationHoursLabel.textAlignment = NSTextAlignmentCenter;
        _durationHoursLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _durationHoursLabel.numberOfLines = 0;
        _durationHoursLabel.alpha = 0;
        [self addSubview:_durationHoursLabel];
        
        _locationLabel = [UILabel new];
        _locationLabel.font = [UIFont regularFont:16];
        _locationLabel.textColor = [UIColor customTextColor];
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        _locationLabel.text = @"                             ";
        _locationLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _locationLabel.numberOfLines = 0;
        _locationLabel.alpha = 0;
        [self addSubview:_locationLabel];
        
        _peopleImageView = [UIImageView new];
        _peopleImageView.clipsToBounds = YES;
        _peopleImageView.contentMode = UIViewContentModeScaleAspectFit;
        _peopleImageView.image = [UIImage imageNamed:@"people"];
        [self addSubview:_peopleImageView];
        
        _timeImageView = [UIImageView new];
        _timeImageView.clipsToBounds = YES;
        _timeImageView.contentMode = UIViewContentModeScaleAspectFit;
        _timeImageView.image = [UIImage imageNamed:@"clock"];
        [self addSubview:_timeImageView];
        
        _locationImageView = [UIImageView new];
        _locationImageView.clipsToBounds = YES;
        _locationImageView.contentMode = UIViewContentModeScaleAspectFit;
        _locationImageView.image = [UIImage imageNamed:@"anchor"];
        [self addSubview:_locationImageView];
        
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:0.5363 green:0.5182 blue:0.3785 alpha:0.5];
        [self addSubview:_lineView];

    }
    
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat totalIconsWidth = kGeomDismmissButton * 3;
    CGFloat widthWithoutIcons = width(self) - totalIconsWidth;
    CGFloat marginSpaceBetweenIcons = widthWithoutIcons / 4;
    
    CGRect frame = _peopleImageView.frame;
    frame.size.width = kGeomDismmissButton;
    frame.size.height = kGeomDismmissButton;
    frame.origin.x = marginSpaceBetweenIcons;
    frame.origin.y = 0;
    _peopleImageView.frame = frame;
    
    frame = _timeImageView.frame;
    frame.size.height = kGeomDismmissButton;
    frame.size.width = kGeomDismmissButton;
    frame.origin.x = CGRectGetMaxX(_peopleImageView.frame) + marginSpaceBetweenIcons;
    frame.origin.y = 0;
    _timeImageView.frame = frame;
    
    frame = _locationImageView.frame;
    frame.size.height = kGeomDismmissButton;
    frame.size.width = kGeomDismmissButton;
    frame.origin.x = CGRectGetMaxX(_timeImageView.frame) +marginSpaceBetweenIcons;
    frame.origin.y = 0;
    _locationImageView.frame = frame;
    
    [_numberOFpeopleLabel sizeToFit];
    [_numberOFpeopleLabel setCenter:CGPointMake(CGRectGetMidX(_peopleImageView.frame), CGRectGetMaxY(_peopleImageView.frame) + kGeomMarginMedium)];
    
    [_durationHoursLabel sizeToFit];
    [_durationHoursLabel setCenter:CGPointMake(CGRectGetMidX(_timeImageView.frame), CGRectGetMaxY(_timeImageView.frame) + kGeomMarginMedium)];
    
    [_locationLabel sizeToFit];
    [_locationLabel setCenter:CGPointMake(CGRectGetMidX(_locationImageView.frame), CGRectGetMaxY(_timeImageView.frame) + kGeomMarginMedium)];
    
    frame = _lineView.frame;
    frame.size.height = kGeomMinSpace;
    frame.size.width = width(self) * 0.8;
    frame.origin.x = (width(self) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_numberOFpeopleLabel.frame) + kGeomMarginMedium;
    _lineView.frame = frame;
    
}

- (void)setCharter:(CharterService *)charter {
    
        if (_charter == charter) return;
        _charter = charter;
    
    int hours = [_charter.durationMinutes intValue] /60;
     _durationHoursLabel.text = [NSString stringWithFormat:@"%d H",hours];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[_charter.latitude doubleValue] longitude:[_charter.longitude doubleValue]];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error){
             NSLog(@"Geocode failed with error: %@", error);
             return;
         }
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
//         NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//         NSLog(@"locality %@",placemark.locality);
//         NSLog(@"postalCode %@",placemark.postalCode);
//         NSLog(@"location %@",placemark.location);
//         NSLog(@"sublocality %@", placemark.subLocality);
         
         __weak InfoView *weakSelf = self;
         dispatch_async(dispatch_get_main_queue(), ^{
             weakSelf.locationLabel.text = placemark.locality;
             [weakSelf setNeedsLayout];
             if (placemark.locality) {
                 [self changeAlpha];
             }
         });
     }];
}

- (void)changeAlpha {
    
    [UIView animateWithDuration:.3 animations:^{
        _numberOFpeopleLabel.alpha = 1;
        _locationLabel.alpha = 1;
        _durationHoursLabel.alpha = 1;
    }];

}








@end
