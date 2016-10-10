//
//  BookingObject.h
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerObject.h"
#import "ItemsObject.h"
#import "CommentsObject.h"
#import "PaymentsObject.h"

@interface BookingObject : NSObject

@property (nonatomic, strong) CustomerObject *customer;
@property (nonatomic, strong) ItemsObject *items;
@property (nonatomic, strong) CommentsObject *comment;
@property (nonatomic, strong) PaymentsObject *payment;
@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSNumber *supplierID;
@property (nonatomic, strong) NSString *supplierName;
@property (nonatomic, strong) NSNumber *totalAmount;
@property (nonatomic, strong) NSNumber *totalDue;
@property (nonatomic, strong) NSNumber *totalPaid;
@property (nonatomic, strong) NSString *totalCurrency;
@property (nonatomic, strong) NSString *status;

//for NO_DATE
@property (nonatomic, strong) NSString *dateCreated;
@property (nonatomic, strong) NSString *dateConfirmed;


- (NSDictionary *)dictionaryFromBookingObject;
+ (BookingObject *)bookingFromDict:(NSDictionary *)dict;

@end
