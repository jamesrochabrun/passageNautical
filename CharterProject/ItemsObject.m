//
//  ItemsObject.m
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ItemsObject.h"

NSString *const kKeyProductCode = @"productCode";
NSString *const kKeyStartTimeLocal = @"startTimeLocal";
NSString *const kKeyAmount = @"amount";
NSString *const kKeyQuantities = @"quantities";
NSString *const KkeyQuantitiesValue = @"value";

@implementation ItemsObject


- (NSArray *)arrayFromItemsObject {
    
    NSArray *items = @[
                @{
                    kKeyProductCode: (_productCode)? _productCode : @"",
                    kKeyStartTimeLocal : (_startTimeLocal)? _startTimeLocal : @"",
                    kKeyAmount : (_amount)? _amount : @"",
                    kKeyQuantities : @[
                            @{
                                KkeyQuantitiesValue : (_quantitiesValue)? _quantitiesValue : @""
                                }
                            ]
                    }
                ];
    return items;
}

@end
