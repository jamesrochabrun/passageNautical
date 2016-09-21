//
//  NetworkManager.m
//  CharterProject
//
//  Created by James Rochabrun on 9/20/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

@synthesize requestManager;

+ (id)sharedRequestManager {
    static NetworkManager *sharedRequestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRequestManager = [[self alloc] init];
        sharedRequestManager.requestManager = [AFHTTPRequestOperationManager manager];
    });
    return sharedRequestManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (AFHTTPRequestOperation *)GET:(NSString *)path parameters:(NSDictionary *)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation*operation, NSError *error))failure
{
     //   NSLog(@"GET:  %@", path);
    NetworkManager *nm = [NetworkManager sharedRequestManager];
    nm.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    nm.requestManager.responseSerializer.acceptableContentTypes = [NSMutableSet setWithObjects:@"application/json", @"text/html", nil];
        
    [nm.requestManager.requestSerializer setValue:nil forHTTPHeaderField:@"Content-Type"];
    
    return [nm.requestManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
           // NSLog(@"JSON: %@", responseObject);
        
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

@end
