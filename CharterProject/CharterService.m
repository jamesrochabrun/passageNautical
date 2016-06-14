//
//  CharterService.m
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CharterService.h"

@implementation CharterService

NSString *const CHname = @"name";
NSString *const CHadvertisedPrice = @"advertisedPrice";
NSString *const CHbookingFields = @"bookingFields";
NSString *const CHbookingMode = @"bookingMode";
NSString *const CHcharter = @"charter";
NSString *const CHconfirmMode = @"confirmMode";
NSString *const CHconfirmModeMinParticpants = @"confirmModeMinParticipants";
NSString *const CHcurrency = @"currency";
NSString *const CHdateUpdated = @"dateUpdated";
NSString *const CHcharterDescription = @"description";
NSString *const CHdurationMinutes = @"durationMinutes";
NSString *const CHextras = @"extras";
NSString *const CHgeneralTerms = @"generalTerms";
NSString *const CHimages = @"images";
NSString *const CHinternalCode = @"internalCode";
NSString *const CHlatitude = @"latitude";
NSString *const CHlongitude = @"longitude";
NSString *const CHlocationAddress = @"locationAddress";
NSString *const CHminimumNoticeMinutes = @"minimumNoticeMinutes";
NSString *const CHpriceOptions = @"priceOptions";
NSString *const CHproductCode = @"productCode";
NSString *const CHproductType = @"productType";
NSString *const CHquantityRequired = @"quantityRequired";
NSString *const CHquantityRequiredMax = @"quantityRequiredMax";
NSString *const CHquantityRequiredMin = @"quantityRequiredMin";
NSString *const CHshortDescription = @"shortDescription";
NSString *const CHsupplierAlias = @"supplierAlias";
NSString *const CHsupplierId = @"supplierId";
NSString *const CHterms = @"terms";
NSString *const CHunitLabel = @"unitLabel";
NSString *const CHunitLabelPlural = @"unitLabelPlural";



- (instancetype)initWithDictionary:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        _name = [dict valueForKey:CHname];
        _advertisedPrice = [dict valueForKey:CHadvertisedPrice];
        _bookingFields = [dict valueForKey:CHbookingFields];
        _bookingMode = [dict valueForKey:CHbookingMode];
        _charter = [dict valueForKey:CHcharter];
        _confirmMode = [dict valueForKey:CHconfirmMode];
        _confirmModeMinParticipants = [dict valueForKey:CHconfirmModeMinParticpants];
        _currency = [dict valueForKey:CHcurrency];
        _dateUpdated = [dict valueForKey:CHdateUpdated];
        _charterDescription = [dict valueForKey:CHcharterDescription];
        _durationMinutes = [dict valueForKey:CHdurationMinutes];
        _extras = [dict valueForKey:CHextras];
        _generalTerms = [dict valueForKey:CHgeneralTerms];
        _images = [dict valueForKey:CHimages];
        _internalCode = [dict valueForKey:CHinternalCode];
        _latitude = [dict valueForKey:CHlatitude];
        _longitude = [dict valueForKey:CHlongitude];
        _locationAddress = [dict valueForKey:CHlocationAddress];
        _minimumNoticeMinutes = [dict valueForKey:CHminimumNoticeMinutes];
        _priceOptions = [dict valueForKey:CHpriceOptions];
        _productCode = [dict valueForKey:CHproductCode];
        _productType = [dict valueForKey:CHproductType];
        _quantityRequired = [dict valueForKey:CHquantityRequired];
        _quantityRequiredMax = [dict valueForKey:CHquantityRequiredMax];
        _quantityRequiredMin = [dict valueForKey:CHquantityRequiredMin];
        _shortDescription = [dict valueForKey:CHshortDescription];
        _supplierAlias = [dict valueForKey:CHsupplierAlias];
        _supplierId = [dict valueForKey:CHsupplierId];
        _terms = [dict valueForKey:CHterms];
        _unitLabel = [dict valueForKey:CHunitLabel];
        _unitLabelPlural = [dict valueForKey:CHunitLabelPlural];
    }
    return self;
}


@end






























