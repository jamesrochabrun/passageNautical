//
//  CharterService.h
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharterService : NSObject

@property NSString *name;
@property NSNumber *advertisedPrice;
@property NSArray *bookingFields;
@property NSString *bookingMode;
@property BOOL charter;
@property NSString *confirmMode;
@property NSNumber *confirmModeMinParticipants;
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
@property NSArray *priceOptions;
@property NSString *productCode;
@property NSString *productType;
@property NSNumber *quantityRequired;
@property NSNumber *quantityRequiredMax;
@property NSNumber *quantityRequiredMin;
@property NSString *shortDescription;
@property NSString *supplierAlias;
@property NSNumber *supplierId;
@property NSString *terms;
@property NSString *unitLabel;
@property NSString *unitLabelPlural;

- (instancetype)initWithName:(NSString*)name advertisedPrice:(NSNumber*)advertisedPrice bookingFields:(NSArray*)bookingFields bookingMode:(NSString*)bookingMode charter:(BOOL)charter confirmMode:(NSString*)confirmMode confirmModeMinParticipants:(NSNumber*)confirmModeMinParticipants currency:(NSString*)currency dateUpdated:(NSString*)dateUpdated charterDescription:(NSString*)charterDescription durationMinutes:(NSNumber*)durationMinutes extras:(NSArray*)extras generalTerms:(NSString*)generalTerms images:(NSArray*)images internalCode:(NSString*)internalCode latitude:(NSString*)latitude longitude:(NSString*)longitude locationAddress:(NSDictionary*)locationAddress minimumNoticeMinutes:(NSNumber*)minimumNoticeMinutes priceOptions:(NSArray*)priceOptions productCode:(NSString*)productCode productType:(NSString*)productType quantityRequired:(NSNumber*)quantityRequired quantityRequiredMax:(NSNumber*)quantityRequiredMax quantityRequiredMin:(NSString*)quantityRequiredMin shortDescription:(NSString*)shortDescription supplierAlias:(NSString*)supplierAlias supplierId:(NSNumber*)supplierId terms:(NSString*)terms unitLabel:(NSString*)unitLabel unitLabelPlural:(NSString*)unitLabelPlural;



@end
