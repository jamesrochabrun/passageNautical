//
//  CharterService.h
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"


extern NSString *const CHname;
extern NSString *const CHadvertisedPrice;
extern NSString *const CHbookingFields;
extern NSString *const CHbookingMode;
extern NSString *const CHcharter;
extern NSString *const CHconfirmMode;
extern NSString *const CHconfirmModeMinParticipants;
extern NSString *const CHcurrency;
extern NSString *const CHdateUpdated;
extern NSString *const CHcharterDescription;
extern NSString *const CHdurationMinutes;
extern NSString *const CHextras;
extern NSString *const CHgeneralTerms;
extern NSString *const CHimages;
extern NSString *const CHinternalCode;
extern NSString *const CHlatitude;
extern NSString *const CHlongitude;
extern NSString *const CHlocationAddress;
extern NSString *const CHminimumNoticeMinutes;
extern NSString *const CHpriceOptions;
extern NSString *const CHproductCode;
extern NSString *const CHproductType;
extern NSString *const CHquantityRequired;
extern NSString *const CHquantityRequiredMax;
extern NSString *const CHquantityRequiredMin;
extern NSString *const CHshortDescription;
extern NSString *const CHsupplierAlias;
extern NSString *const CHsupplierId;
extern NSString *const CHterms;
extern NSString *const CHunitLabel;
extern NSString *const CHunitLabelPlural;

@interface CharterService : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *advertisedPrice;
@property (nonatomic, strong) NSArray *bookingFields;
@property (nonatomic, strong) NSString *bookingMode;
@property id charter;
@property (nonatomic, strong) NSString *confirmMode;
@property (nonatomic, strong) NSNumber *confirmModeMinParticipants;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *dateUpdated;
@property (nonatomic, strong) NSString *charterDescription;
@property (nonatomic, strong) NSNumber *durationMinutes;
@property (nonatomic, strong) NSArray *extras;
@property (nonatomic, strong) NSString *generalTerms;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *internalCode;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSDictionary *locationAddress;
@property (nonatomic, strong) NSNumber *minimumNoticeMinutes;
@property (nonatomic, strong) NSArray *priceOptions;
@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, strong) NSNumber *quantityRequired;
@property (nonatomic, strong) NSNumber *quantityRequiredMax;
@property (nonatomic, strong) NSNumber *quantityRequiredMin;
@property (nonatomic, strong) NSString *shortDescription;
@property (nonatomic, strong) NSString *supplierAlias;
@property (nonatomic, strong) NSNumber *supplierId;
@property (nonatomic, strong) NSString *terms;
@property (nonatomic, strong) NSString *unitLabel;
@property (nonatomic, strong) NSString *unitLabelPlural;
@property (nonatomic, strong) NSString *imageURL;

+ (CharterService *)charterServiceFromDict:(NSDictionary *)dict;












@end
