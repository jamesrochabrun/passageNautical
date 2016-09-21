//
//  CharterService.m
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CharterService.h"
#import "Common.h"

@implementation CharterService

NSString *const CHname = @"name";
NSString *const CHadvertisedPrice = @"advertisedPrice";
NSString *const CHbookingFields = @"bookingFields";
NSString *const CHbookingMode = @"bookingMode";
NSString *const CHcharter = @"charter";
NSString *const CHconfirmMode = @"confirmMode";
NSString *const CHconfirmModeMinParticipants = @"confirmModeMinParticipants";
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


+ (CharterService *)charterServiceFromDict:(NSDictionary *)dict {
    
    CharterService *charter = [CharterService new];
    charter.name = parseStringOrNullFromServer(dict[CHname]);
    charter.advertisedPrice = parseNSNumberOrNullFromServer(dict[CHadvertisedPrice]);
    charter.bookingFields = parseArrayOrNullFromServer(dict[CHbookingFields]);
    charter.bookingMode = parseStringOrNullFromServer(dict[CHbookingMode]);
    charter.charter = dict[CHcharter];
    charter.confirmMode = parseStringOrNullFromServer(dict[CHconfirmMode]);
    charter.confirmModeMinParticipants = parseNSNumberOrNullFromServer(dict[CHconfirmModeMinParticipants]);
    charter.currency = parseStringOrNullFromServer(dict[CHcurrency]);
    charter.dateUpdated = parseStringOrNullFromServer(dict[CHdateUpdated]);
    charter.charterDescription = parseStringOrNullFromServer(dict[CHcharterDescription]);
    charter.durationMinutes = parseNSNumberOrNullFromServer(dict[CHdurationMinutes]);
    charter.extras = parseArrayOrNullFromServer(dict[CHextras]);
    charter.generalTerms = parseStringOrNullFromServer(dict[CHgeneralTerms]);
    charter.images = parseArrayOrNullFromServer(dict[CHimages]);
    charter.internalCode = parseStringOrNullFromServer(dict[CHinternalCode]);
    charter.latitude = parseStringOrNullFromServer(dict[CHlatitude]);
    charter.longitude = parseStringOrNullFromServer(dict[CHlongitude]);
    charter.locationAddress = parseDictionaryOrNullFromServer(dict[CHlocationAddress]);
    charter.minimumNoticeMinutes = parseNSNumberOrNullFromServer(dict[CHminimumNoticeMinutes]);
    charter.priceOptions = parseArrayOrNullFromServer(dict[CHpriceOptions]);
    charter.productCode = parseStringOrNullFromServer(dict[CHproductCode]);
    charter.productType = parseStringOrNullFromServer(dict[CHproductType]);
    charter.quantityRequired = parseNSNumberOrNullFromServer(dict[CHquantityRequired]);
    charter.quantityRequiredMax = parseNSNumberOrNullFromServer(dict[CHquantityRequiredMax]);
    charter.quantityRequiredMin = parseNSNumberOrNullFromServer(dict[CHquantityRequiredMin]);
    charter.shortDescription = parseStringOrNullFromServer(dict[CHshortDescription]);
    charter.supplierAlias = parseStringOrNullFromServer(dict[CHsupplierAlias]);
    charter.supplierId = parseNSNumberOrNullFromServer(dict[CHsupplierId]);
    charter.terms = parseStringOrNullFromServer(dict[CHterms]);
    charter.unitLabel = parseStringOrNullFromServer(dict[CHunitLabel]);
    charter.unitLabelPlural = parseStringOrNullFromServer(dict[CHunitLabelPlural]);
    return charter;
 
}


- (instancetype)initWithDictionary:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        _name = [dict valueForKey:CHname];
        _advertisedPrice = [dict valueForKey:CHadvertisedPrice];
        _bookingFields = [dict valueForKey:CHbookingFields];
        _bookingMode = [dict valueForKey:CHbookingMode];
        _charter = [dict valueForKey:CHcharter];
        _confirmMode = [dict valueForKey:CHconfirmMode];
        _confirmModeMinParticipants = [dict valueForKey:CHconfirmModeMinParticipants];
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






























