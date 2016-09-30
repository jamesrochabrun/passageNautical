//
//  CustomerObject.h
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerObject : NSObject

extern NSString *const kKeyPostCode;
extern NSString *const kKeyState;
extern NSString *const kKeyCity;
extern NSString *const kKeyAddressLine;
extern NSString *const kKeyCompanyName;
extern NSString *const kKeyFirstName;
extern NSString *const kKeyLastName;
extern NSString *const kKeyEmail;
extern NSString *const kKeyPhone;

@property (nonatomic, strong) NSString *postCode;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *addressLine;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;

- (NSDictionary *)dictionaryFromCustomerObject;



@end
