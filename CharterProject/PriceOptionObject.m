//
//  PriceOptionObject.m
//  CharterProject
//
//  Created by James Rochabrun on 10/5/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "PriceOptionObject.h"
#import "Common.h"


NSString *const kKeyOptionID = @"id";
NSString *const kKeyPriceOption = @"price";
NSString *const kKeyOptionLabel = @"label";
NSString *const kKeySeatsUsed = @"seatsUsed";
NSString *const kKeyPriceGroupType = @"priceGroupType";

@implementation PriceOptionObject

+ (PriceOptionObject *)priceOptionFromDict:(NSDictionary *)dict {
    
    PriceOptionObject *priceOptionObject = [PriceOptionObject new];
    priceOptionObject.priceOptionID = parseNSNumberOrNullFromServer(dict[kKeyOptionID]);
    priceOptionObject.price = parseNSNumberOrNullFromServer(dict[kKeyPriceOption]);
    priceOptionObject.priceOptionLabel = parseStringOrNullFromServer(dict[kKeyOptionLabel]);
    priceOptionObject.seatsUsed = parseNSNumberOrNullFromServer(dict[kKeySeatsUsed]);
    priceOptionObject.priceGroupType = parseStringOrNullFromServer(dict[kKeyPriceGroupType]);
    
    return priceOptionObject;
}


@end
