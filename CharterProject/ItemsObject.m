//
//  ItemsObject.m
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ItemsObject.h"
#import "Common.h"

NSString *const kKeyProductCode = @"productCode";
NSString *const kKeyStartTimeLocal = @"startTimeLocal";
NSString *const kKeyAmount = @"amount";
NSString *const kKeyQuantities = @"quantities";
NSString *const KkeyQuantitiesValue = @"value";
NSString *const kKeyProductName = @"productName";
NSString *const kKeySubTotal = @"subtotal";
NSString *const kKeytotalQuantity = @"totalQuantity";
NSString *const kKeyOptionlabel = @"optionLabel";


@implementation ItemsObject


- (NSArray *)arrayFromItemsObject {
    
    NSArray *items = @[
                @{
                    kKeyProductCode: (_productCode)? _productCode : @"",
                    kKeyStartTimeLocal : (_startTimeLocal)? _startTimeLocal : @"",
                    kKeyAmount : (_amount)? _amount : @"",
                    kKeyQuantities : @[
                            @{
                                KkeyQuantitiesValue : (_quantitiesValue)? _quantitiesValue : @"",
                                kKeyOptionlabel : (_optionLabel)? _optionLabel :@""
                                }
                            ]
                    }
                ];
    return items;
}

+ (ItemsObject *)itemsObjectFromDict:(NSDictionary *)dict {
    
    ItemsObject *item = [ItemsObject new];
    item.amount = parseNSNumberOrNullFromServer(dict[kKeyAmount]);
    item.productCode = parseStringOrNullFromServer(dict[kKeyProductCode]);
    item.startTimeLocal = parseStringOrNullFromServer(dict[kKeyStartTimeLocal]);
    item.productName = parseStringOrNullFromServer(dict[kKeyProductName]);
    item.quantities = parseArrayOrNullFromServer(dict[kKeyQuantities]);
    item.subTotal = parseNSNumberOrNullFromServer(dict[kKeySubTotal]);
    item.totalQuantity = parseNSNumberOrNullFromServer(dict[kKeytotalQuantity]);
    return item;
    
}

@end
