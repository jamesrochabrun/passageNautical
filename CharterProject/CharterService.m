//
//  CharterService.m
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CharterService.h"

@implementation CharterService
- (instancetype)initWithName:(NSString*)name advertisedPrice:(NSNumber*)advertisedPrice bookingFields:(NSArray*)bookingFields bookingMode:(NSString*)bookingMode charter:(BOOL)charter confirmMode:(NSString*)confirmMode confirmModeMinParticipants:(NSNumber*)confirmModeMinParticipants currency:(NSString*)currency dateUpdated:(NSString*)dateUpdated charterDescription:(NSString*)charterDescription durationMinutes:(NSNumber*)durationMinutes extras:(NSArray*)extras generalTerms:(NSString*)generalTerms images:(NSArray*)images internalCode:(NSString*)internalCode latitude:(NSString*)latitude longitude:(NSString*)longitude locationAddress:(NSDictionary*)locationAddress minimumNoticeMinutes:(NSNumber*)minimumNoticeMinutes priceOptions:(NSArray*)priceOptions productCode:(NSString*)productCode productType:(NSString*)productType quantityRequired:(NSNumber*)quantityRequired quantityRequiredMax:(NSNumber*)quantityRequiredMax quantityRequiredMin:(NSNumber*)quantityRequiredMin shortDescription:(NSString*)shortDescription supplierAlias:(NSString*)supplierAlias supplierId:(NSNumber*)supplierId terms:(NSString*)terms unitLabel:(NSString*)unitLabel unitLabelPlural:(NSString*)unitLabelPlural{
    
    self = [super init];
    if (self) {
        self.name = name;
        self.advertisedPrice = advertisedPrice;
        self.bookingFields = bookingFields;
        self.bookingMode = bookingMode;
        self.charter = charter;
        self.confirmMode = confirmMode;
        self.confirmModeMinParticipants = confirmModeMinParticipants;
        self.currency = currency;
        self.dateUpdated = dateUpdated;
        self.charterDescription = charterDescription;
        self.durationMinutes = durationMinutes;
        self.extras = extras;
        self.generalTerms = generalTerms;
        self.images = images;
        self.internalCode = internalCode;
        self.latitude = latitude;
        self.longitude = longitude;
        self.locationAddress = locationAddress;
        self.minimumNoticeMinutes = minimumNoticeMinutes;
        self.priceOptions = priceOptions;
        self.productCode = productCode;
        self.productType = productType;
        self.quantityRequired = quantityRequired;
        self.quantityRequiredMax = quantityRequiredMax;
        self.quantityRequiredMin = quantityRequiredMin;
        self.shortDescription = shortDescription;
        self.supplierAlias = supplierAlias;
        self.supplierId = supplierId;
        self.terms = terms;
        self.unitLabel = unitLabel;
        self.unitLabelPlural = unitLabelPlural;
    }
    return self;
   
}



@end
