//
//  SessionObject.h
//  CharterProject
//
//  Created by James Rochabrun on 10/5/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionObject : NSObject
@property (nonatomic, strong) NSNumber *sessionID;
@property (nonatomic, strong) NSString *productCode;
@property (nonatomic, strong) NSString *startTimeLocal;
@property (nonatomic, strong) NSString *endTimeLocal;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property id allDay;
@property (nonatomic, strong) NSNumber *seats;
@property (nonatomic, strong) NSNumber *seatsAvailable;
@property (nonatomic, strong) NSMutableArray *priceOptions;

+ (SessionObject *)sessionFromDict:(NSDictionary *)dict;

@end
