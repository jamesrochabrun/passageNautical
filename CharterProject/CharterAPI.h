//
//  CharterAPI.h
//  CharterProject
//
//  Created by James Rochabrun on 9/20/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"


@interface CharterAPI : NSObject

+ (NSString *)URL;

+ (AFHTTPRequestOperation *)getListOfServicesByID:(NSString *)listID
                                        success:(void (^)(NSArray *services))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
