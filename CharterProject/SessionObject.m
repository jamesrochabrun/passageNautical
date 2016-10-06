//
//  SessionObject.m
//  CharterProject
//
//  Created by James Rochabrun on 10/5/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "SessionObject.h"
#import "Common.h"
#import "PriceOptionObject.h"

//@property (nonatomic, strong) NSNumber *sessionID;
//@property (nonatomic, strong) NSString *productCode;
//@property (nonatomic, strong) NSString *startTimeLocal;
//@property (nonatomic, strong) NSString *endTimeLocal;
//@property (nonatomic, strong) NSString *startTime;
//@property (nonatomic, strong) NSString *endTime;
//@property id allDay;
//@property (nonatomic, strong) NSNumber *seats;
//@property (nonatomic, strong) NSNumber *seatsAvailable;
//@property (nonatomic, strong) NSMutableArray *priceOptions;

NSString *const kKeySessionID = @"id";
NSString *const kKeysessionProductCode = @"productCode";
NSString *const kKeysessionStartTimeLocal = @"startTimeLocal";
NSString *const kKeySessionEndTimeLocal = @"endTimeLocal";
NSString *const kKeyStartTime = @"startTime";
NSString *const kKeyEndTime = @"endTime";
NSString *const kKeyAllDay = @"allDay";
NSString *const kKeySeats = @"seats";
NSString *const kKeySeatsAvailable = @"seatsAvailable";
NSString *const kKeyPriceOptions = @"priceOptions";

@implementation SessionObject

+ (SessionObject *)sessionFromDict:(NSDictionary *)dict {
    
    SessionObject *session = [SessionObject new];
    session.sessionID = parseNSNumberOrNullFromServer(dict[kKeySessionID]);
    session.productCode = parseStringOrNullFromServer(dict[kKeysessionProductCode]);
    session.startTimeLocal = parseStringOrNullFromServer(dict[kKeysessionStartTimeLocal]);
    session.endTimeLocal = parseStringOrNullFromServer(dict[kKeySessionEndTimeLocal]);
    session.startTime = parseStringOrNullFromServer(dict[kKeyStartTime]);
    session.endTime = parseStringOrNullFromServer(dict[kKeyEndTime]);
    session.allDay = dict[kKeyAllDay];
    session.seats = parseNSNumberOrNullFromServer(dict[kKeySeats]);
    session.seatsAvailable = parseNSNumberOrNullFromServer(dict[kKeySeatsAvailable]);
    
    NSArray *arr = parseArrayOrNullFromServer(dict[kKeyPriceOptions]);
    session.priceOptions = [NSMutableArray new];
    for (NSDictionary *priceOptionDict in arr) {
        PriceOptionObject *priceOption = [PriceOptionObject priceOptionFromDict:priceOptionDict];
        [session.priceOptions addObject:priceOption];
    }
    return session;
    
}

@end
