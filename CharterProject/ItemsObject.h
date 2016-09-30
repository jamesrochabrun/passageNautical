//
//  ItemsObject.h
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsObject : NSObject

@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *startTimeLocal;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSArray *quantities;
@property (nonatomic, strong) NSNumber *quantitiesValue;

- (NSArray *)arrayFromItemsObject;



@end
