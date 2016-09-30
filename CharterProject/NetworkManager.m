//
//  NetworkManager.m
//  CharterProject
//
//  Created by James Rochabrun on 9/20/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "NetworkManager.h"

static NSString *contentType = @"Content-Type";
static NSString *applicationJson = @"application/json";
static NSString *textHtml = @"text/html";

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
    //NSLog(@"GET:  %@", path);
    NetworkManager *nm = [NetworkManager sharedRequestManager];
    nm.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    nm.requestManager.responseSerializer.acceptableContentTypes = [NSMutableSet setWithObjects:applicationJson, textHtml , nil];
        
    [nm.requestManager.requestSerializer setValue:nil forHTTPHeaderField:contentType];
    
    return [nm.requestManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

//- (AFHTTPRequestOperation *)POST:(NSString *)path parameters:(id)parameters
//                         success:(void (^)(id responseObject))success
//                         failure:(void (^)(AFHTTPRequestOperation*operation, NSError *error))failure
//{
//    //NSLog(@"POST: %@", path);
//    NetworkManager *nm = [NetworkManager sharedRequestManager];
//    nm.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    nm.requestManager.responseSerializer.acceptableContentTypes = [NSMutableSet setWithObjects:applicationJson, textHtml, nil];
//    
//
//    
//    //[nm.requestManager.requestSerializer setValue:nil forHTTPHeaderField:@"Content-Type"];
//    [nm.requestManager.requestSerializer setValue:applicationJson forHTTPHeaderField:contentType];
//        [nm.requestManager.requestSerializer setValue:applicationJson forHTTPHeaderField:@"Accept"];
//
//    NSLog (@"POST PARAMETERS:  %@",parameters);
//    NSLog (@"SERIALIZER SAYS HEADERS:  %@", nm.requestManager.requestSerializer.HTTPRequestHeaders);
//    //NSLog (@"SERIALIZER SAYS TIMEOUT:   %g", nm.requestManager.requestSerializer.timeoutInterval);
//    return [nm.requestManager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//               NSLog(@"success JSON: %@", responseObject);;
//        success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(operation,error);
//        
//        NSLog(@"error - the response string is %@" , operation.responseString);
//        NSLog(@"error - the response object is %@", operation.responseObject);
//        //NSLog(@"the error is %@", error);
//    }];
//}



@end
