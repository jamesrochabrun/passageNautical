//
//  CharterAPI.m
//  CharterProject
//
//  Created by James Rochabrun on 9/20/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CharterAPI.h"
#import "CharterService.h"
#import "NSString+DecodeHTML.h"
#import "SessionObject.h"


NSString *const kKeyapiKey = @"apiKey=15132eb9747f46baaa149e85aab49aeb";
NSString *const kKeyHTTPProtocol = @"https";
NSString *const kKeyURLProduction = @"api.rezdy.com/v1";
NSString *const kKeyFromProducts = @"products";
NSString *const kKeyFromSessions = @"sessions";



@interface CharterAPI()
@end

@implementation CharterAPI

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (AFHTTPRequestOperation *)getListOfServicesByID:(NSString *)listID
                                          success:(void (^)(NSArray *services))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/categories/%@/products?%@", kKeyHTTPProtocol, [CharterAPI URL], listID, kKeyapiKey];
    
    NetworkManager *nm = [NetworkManager new];
    
    AFHTTPRequestOperation *op = [nm GET:urlString parameters:nil success:^(id responseObject) {
        
       NSArray *arrayData = responseObject[kKeyFromProducts];
    
        NSMutableArray *categoryProductsArray = [NSMutableArray new];
        
        for (id dict in arrayData) {
            CharterService *charterService = [CharterService charterServiceFromDict:dict];
            [categoryProductsArray addObject:charterService];
        }
        success(categoryProductsArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
                                  
    return op;
}

+ (AFHTTPRequestOperation *)checkAvailabilityForProduct:(CharterService *)charterService
                                                   from:(NSString *)startDate
                                                  until:(NSString *)endDate
                                                success:(void (^)(NSArray *sessions))success
                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    
    NSString *endPoint = [NSString stringWithFormat:@"%@://%@/availability?endTimeLocal=%@&productCode=%@&startTimeLocal=%@&%@", kKeyHTTPProtocol , [CharterAPI URL], endDate, charterService.productCode, startDate , kKeyapiKey];
    
    NSString *endPointEncode = [endPoint stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    NetworkManager *nm = [NetworkManager new];
    
    AFHTTPRequestOperation *op = [nm GET:endPointEncode parameters:nil success:^(id responseObject) {
        
        NSArray *arrayData = responseObject[kKeyFromSessions];
        
        NSMutableArray *sessionsArray = [NSMutableArray new];
        
        for (id dict in arrayData) {
            SessionObject *session = [SessionObject sessionFromDict:dict];
            [sessionsArray addObject:session];
        }
        success(sessionsArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
    
    return op;
}


//NSURLSESSION
- (void)sendBooking:(NSDictionary *)booking
                        success:(void (^)(id responseObject))success {
    
    NSError *error;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/bookings?%@", kKeyHTTPProtocol, [CharterAPI URL], kKeyapiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:booking options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"HEADER RESPONSE %@", response);
        
        //NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
       /// NSData *data = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *dictResponse = json;
        success(dictResponse);
    }];
    
    [postDataTask resume];
    
}


+ (NSString *)URL {
    return kKeyURLProduction;
}

@end
