//
//  CharterAPI.h
//  CharterProject
//
//  Created by James Rochabrun on 9/20/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
@class CharterService;


@interface CharterAPI : NSObject<NSURLSessionDelegate>

+ (NSString *)URL;

//PRODUCTS
+ (AFHTTPRequestOperation *)getListOfServicesByID:(NSString *)listID
                                        success:(void (^)(NSArray *services))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//SESSIONS
+ (AFHTTPRequestOperation *)checkAvailabilityForProduct:(CharterService *)charterService
                                                   from:(NSString *)startDate
                                                  until:(NSString *)endDate
                                                success:(void (^)(NSArray *sessions))success
                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


//BOOKINGS
- (void)sendBooking:(NSDictionary *)booking
            success:(void (^)(id responseObject))success;

@end

