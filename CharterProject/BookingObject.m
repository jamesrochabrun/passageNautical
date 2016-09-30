//
//  BookingObject.m
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "BookingObject.h"
#import "CustomerObject.h"
#import "ItemsObject.h"
#import "CommentsObject.h"
#import "PaymentsObject.h"

NSString *const kKeyCustomer = @"customer";
NSString *const kKeyItems = @"items";
NSString *const kKeyComments = @"comments";
NSString *const kKeyPayments = @"payments";

@implementation BookingObject

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _customer = [CustomerObject new];
        _items = [ItemsObject new];
        _comment = [CommentsObject new];
        _payment = [PaymentsObject new];
    }
    return self;
}

- (NSDictionary *)dictionaryFromBookingObject {
    
    NSDictionary *booking = @{ kKeyCustomer : [_customer dictionaryFromCustomerObject],
                               kKeyItems : [_items arrayFromItemsObject],
                               kKeyComments : [_comment stringFromCommentsObject],
                               kKeyPayments : [_payment arrayFromPaymentsObject]
    
                               };

    return booking;
}
@end
