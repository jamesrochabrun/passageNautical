//
//  PriceOptionObject.h
//  CharterProject
//
//  Created by James Rochabrun on 10/5/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceOptionObject : NSObject
@property (nonatomic, strong) NSNumber *priceOptionID;
@property (nonatomic, strong) NSString *priceOptionLabel;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *seatsUsed;
@property (nonatomic, strong) NSString *priceGroupType;
@property (nonatomic, strong) NSMutableArray *priceOptions;
+ (PriceOptionObject *)priceOptionFromDict:(NSDictionary *)dict;

@end
