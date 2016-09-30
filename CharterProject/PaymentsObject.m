//
//  PaymentsObject.m
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "PaymentsObject.h"

NSString *const kKeyType =  @"type";
NSString *const kKeyAmountPayment = @"amount";
NSString *const kKeyCurrency = @"currency";
NSString *const kKeyDate = @"date";
NSString *const kKeyLabel = @"label";


@implementation PaymentsObject


- (NSArray *)arrayFromPaymentsObject {
    
    NSArray *payments =  @[
                           @{
                               kKeyType : (_type)? _type :@"",
                               kKeyAmountPayment : (_amountPayment)? _amountPayment :@"",
                               kKeyCurrency : (_currency)? _currency :@"",
                               kKeyDate : (_date)? _date :@"",
                               kKeyLabel : (_label)? _label :@""
                               }
                           ];
    return payments;
}

@end
