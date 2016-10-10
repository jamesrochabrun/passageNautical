//
//  ItemsObject.h
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PriceOptionObject.h"

@interface ItemsObject : NSObject

@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *startTimeLocal;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSArray *quantities;
@property (nonatomic, strong) NSNumber *quantitiesValue;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSNumber *subTotal;
@property (nonatomic, strong) NSNumber *totalQuantity;
@property (nonatomic, strong) NSString *optionLabel;

- (NSArray *)arrayFromItemsObject;
+ (ItemsObject *)itemsObjectFromDict:(NSDictionary *)dict;


@end
