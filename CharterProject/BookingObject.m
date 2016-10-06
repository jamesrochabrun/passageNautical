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
#import "Common.h"

NSString *const kKeyCustomer = @"customer";
NSString *const kKeyItems = @"items";
NSString *const kKeyComments = @"comments";
NSString *const kKeyPayments = @"payments";
NSString *const kKeyorderNumber = @"orderNumber";
NSString *const kKeySource = @"source";
NSString *const kKeySupplierID = @"supplierID";
NSString *const kKeySupplierName = @"supplierName";
NSString *const kKeyTotalAmount = @"totalAmount";
NSString *const kKeyTotalDue = @"totalDue";
NSString *const kKeyTotalPaid = @"totalPaid";
NSString *const kKeyTotalCurrency = @"totalCurrency";
NSString *const kKeyDateCreated = @"dateCreated";
NSString *const kKeyDateConfirmed = @"dateConfirmed";
NSString *const kKeyStatus = @"status";

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

+ (BookingObject *)bookingFromDict:(NSDictionary *)dict {
    
    BookingObject *bookingObject = [BookingObject new];
    bookingObject.comment.comments = parseStringOrNullFromServer(dict[kKeyComments]);
    bookingObject.customer = [CustomerObject customerFromDict:dict[kKeyCustomer]];
    NSArray *itemsArray = parseArrayOrNullFromServer(dict[kKeyItems]);
    NSDictionary *itemDict = [itemsArray firstObject];
    bookingObject.items = [ItemsObject itemsObjectFromDict:itemDict];
    NSArray *paymentsArray = parseArrayOrNullFromServer(dict[kKeyPayments]);
    NSDictionary *paymentDict = [paymentsArray firstObject];
    bookingObject.payment = [PaymentsObject paymentFromDict:paymentDict];
    bookingObject.orderNumber = parseStringOrNullFromServer(dict[kKeyorderNumber]);
    bookingObject.source = parseStringOrNullFromServer(dict[kKeySource]);
    bookingObject.supplierID = parseNSNumberOrNullFromServer(dict[kKeySupplierID]);
    bookingObject.supplierName = parseStringOrNullFromServer(dict[kKeySupplierName]);
    bookingObject.totalAmount = parseNSNumberOrNullFromServer(dict[kKeyTotalAmount]);
    bookingObject.totalDue = parseNSNumberOrNullFromServer(dict[kKeyTotalDue]);
    bookingObject.totalPaid = parseNSNumberOrNullFromServer(dict[kKeyTotalPaid]);
    bookingObject.totalCurrency = parseStringOrNullFromServer(dict[kKeyTotalCurrency]);
    bookingObject.dateCreated = parseStringOrNullFromServer(dict[kKeyDateCreated]);
    bookingObject.dateConfirmed = parseStringOrNullFromServer(dict[kKeyDateConfirmed]);
    bookingObject.status = parseStringOrNullFromServer(dict[kKeyStatus]);
    return bookingObject;
    
}



@end
