//
//  CharterService.m
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CharterService.h"
#import "Common.h"
#import "PriceOptionObject.h"


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
NSString *const CHimageURL = @"itemUrl";


@implementation CharterService

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
    charter.latitude = parseNSNumberOrNullFromServer(dict[CHlatitude]);
    charter.longitude = parseNSNumberOrNullFromServer(dict[CHlongitude]);
    charter.locationAddress = parseDictionaryOrNullFromServer(dict[CHlocationAddress]);
    charter.minimumNoticeMinutes = parseNSNumberOrNullFromServer(dict[CHminimumNoticeMinutes]);
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
    
    //setting the ImageURL :
    NSDictionary *imagesDictionary = [charter.images firstObject];
    charter.imageURL = [self urlStringWithNoSpaces:imagesDictionary];
    
    //setting the PriceOptionObject
    NSArray *arr = parseArrayOrNullFromServer(dict[CHpriceOptions]);
    charter.priceOptions = [NSMutableArray new];
    for (NSDictionary *priceOptionDict in arr) {
        PriceOptionObject *priceOption = [PriceOptionObject priceOptionFromDict:priceOptionDict];
        [charter.priceOptions addObject:priceOption];
    }
    
    return charter;
}

+ (NSString *)urlStringWithNoSpaces:(NSDictionary *)dict {
    
    NSString *itemUrl = [dict valueForKey:CHimageURL];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    return itemUrlWithNoSpaces;
}






@end






























