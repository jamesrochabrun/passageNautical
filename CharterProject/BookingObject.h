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
- (NSDictionary *)dictionaryFromBookingObject;

@end
