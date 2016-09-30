//
//  CustomerObject.m
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CustomerObject.h"

NSString *const kKeyPostCode =  @"postCode";
NSString *const kKeyState = @"state";
NSString *const kKeyCity = @"city";
NSString *const kKeyAddressLine = @"addressLine";
NSString *const kKeyCompanyName = @"companyName";
NSString *const kKeyFirstName = @"firstName";
NSString *const kKeyLastName = @"lastName";
NSString *const kKeyEmail = @"email";
NSString *const kKeyPhone = @"phone";

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

@end
