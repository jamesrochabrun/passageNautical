//
//  NetworkManager.h
//  CharterProject
//
//  Created by James Rochabrun on 9/20/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface NetworkManager : NSObject {
    AFHTTPRequestOperationManager *_requestManager;
}
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
+ (id)sharedRequestManager;

- (AFHTTPRequestOperation *)GET:(NSString *)path parameters:(NSDictionary *)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation*operation, NSError *error))failure;

//- (AFHTTPRequestOperation *)POST:(NSString *)path parameters:(id)parameters
//                         success:(void (^)(id responseObject))success
//                         failure:(void (^)(AFHTTPRequestOperation*operation, NSError *error))failure;

@end
