//
//  CharterService.h
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharterService : NSObject
@property NSNumber *advertisedPrice;
@property NSArray *bookingFields;
@property NSString *bookingMode;
@property BOOL charter;
@property NSString *confirmMode;
@property NSString *confirmModeMinParticipants;
@property NSString *currency;
@property NSString *dateUpdated;
@property NSString *charterDescription;
@property NSNumber *durationMinutes;
@property NSArray *extras;
@property NSString *generalTerms;
@property NSArray *images;
@property NSString *internalCode;
@property NSString *latitude;
@property NSString *longitude;
@property NSDictionary *locationAddress;
@property NSNumber *minimumNoticeMinutes;
@property NSString *name;
@property NSArray *priceOptions;
@property NSString *productCode;
@property NSString *productType;
@property NSNumber *quantityRequired;
@property NSNumber *quantityRequiredMax;
@property NSNumber *quantityRequiredMin;
@property NSString *shortDescription ;
@property NSString *supplierAlias;
@property NSNumber *supplierId;
@property NSString *terms;
@property NSString *unitLabel;
@property NSString *unitLabelPlural;


@end
