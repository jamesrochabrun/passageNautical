//
//  CustomerObject.m
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CustomerObject.h"
#import "Common.h"

NSString *const kKeyPostCode =  @"postCode";
NSString *const kKeyState = @"state";
NSString *const kKeyCity = @"city";
NSString *const kKeyAddressLine = @"addressLine";
NSString *const kKeyCompanyName = @"companyName";
NSString *const kKeyFirstName = @"firstName";
NSString *const kKeyLastName = @"lastName";
NSString *const kKeyEmail = @"email";
NSString *const kKeyPhone = @"phone";
NSString *const kKeyID = @"id";

@implementation CustomerObject

- (NSDictionary *)dictionaryFromCustomerObject {
    
    NSDictionary *customer =   @{
                                 kKeyPostCode : (_postCode)? _postCode : @"",
                                 kKeyState : (_state)? _state : @"",
                                 kKeyCity : (_city)? _city :@"",
                                 kKeyAddressLine : (_addressLine)? _addressLine :@"",
                                 kKeyCompanyName : (_companyName)? _companyName :@"",
                                 kKeyFirstName : (_firstName)? _firstName :@"",
                                 kKeyLastName : (_lastName)? _lastName :@"",
                                 kKeyEmail : (_email)? _email :@"",
                                 kKeyPhone : (_phone)? _phone :@"",
                                 };
    return customer;
    
}

+ (CustomerObject *)customerFromDict:(NSDictionary *)dict {
    
    CustomerObject *customer = [CustomerObject new];
    customer.firstName = parseStringOrNullFromServer(dict[kKeyFirstName]);
    customer.lastName = parseStringOrNullFromServer(dict[kKeyLastName]);
    customer.email = parseStringOrNullFromServer(dict[kKeyEmail]);
    customer.postCode = parseStringOrNullFromServer(dict[kKeyPostCode]);
    customer.state = parseStringOrNullFromServer(dict[kKeyState]);
    customer.city = parseStringOrNullFromServer(dict[kKeyCity]);
    customer.addressLine = parseStringOrNullFromServer(dict[kKeyAddressLine]);
    customer.phone = parseStringOrNullFromServer(dict[kKeyPhone]);
    customer.customerID = parseNSNumberOrNullFromServer(dict[kKeyID]);
    
    return customer;
    
}







@end
