//
//  PaymentsObject.h
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentsObject : NSObject

extern NSString *const kKeyType;
extern NSString *const kKeyAmount;
extern NSString *const kKeyCurrency;
extern NSString *const kKeyDate;
extern NSString *const kKeyLabel;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSNumber *amountPayment;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *label;
- (NSArray *)arrayFromPaymentsObject;

@end
