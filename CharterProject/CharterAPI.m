//
//  CharterAPI.m
//  CharterProject
//
//  Created by James Rochabrun on 9/20/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CharterAPI.h"
#import "CharterService.h"


NSString *const kapiKey = @"apiKey=8d9c11062ab244c7ab15f44dcaa30c7b";
NSString *const kHTTPProtocol = @"https";
NSString *const kURLProduction = @"api.rezdy.com/v1";
NSString *const keyFromJSON = @"products";


@interface CharterAPI()
- (NSString *)charterURL;
@end

@implementation CharterAPI

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (NSString *)charterURL {
    return [CharterAPI URL];
}

+ (AFHTTPRequestOperation *)getListOfServicesByID:(NSString *)listID
                                          success:(void (^)(NSArray *services))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/categories/%@/products?%@", kHTTPProtocol, [CharterAPI URL], listID, kapiKey];
    
    NetworkManager *nm = [NetworkManager new];
    
    AFHTTPRequestOperation *op = [nm GET:urlString parameters:nil success:^(id responseObject) {
        
       NSArray *arrayData = responseObject[keyFromJSON];
    
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

//NSURLSESSION
- (void)sendBooking:(NSDictionary *)booking
                        success:(void (^)(id responseObject))success
            failure:(void (^)(NSURLResponse *response, NSError *error))failure {
    
    NSError *error;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/bookings?%@", kHTTPProtocol, [CharterAPI URL], kapiKey];
    
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
        
        //NSLog(@"response %@", response);
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        success(string);
    }];
    
    [postDataTask resume];
    
}





//+ (AFHTTPRequestOperation *)bookService:(id)charterJson
//                                success:(void (^)())success
//                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
//    
//    
////    if  (!charter) {
////        failure (nil,nil);
////        return nil;
////    }
//    
//    
//    
//    //https://api.rezdy.com/v1/bookings?apiKey=8d9c11062ab244c7ab15f44dcaa30c7b
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@://%@/bookings?%@", kHTTPProtocol, [CharterAPI URL], kapiKey];
//    
////    NSString *urlString = @"https://api.rezdy.com/latest/bookings?apiKey=8d9c11062ab244c7ab15f44dcaa30c7b";
//    
//   NSLog(@"the post string is %@", urlString);
//    
//   // NSDictionary *parameters = @{@"bookings" : charterJson};
//    //parameters
//    NetworkManager *rm = [NetworkManager new];
//    
//    AFHTTPRequestOperation *op = [rm POST:urlString parameters:charterJson success:^(id responseObject) {
//        
//        success(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//    
//    return op;
//}


+ (NSString *)URL {
    return kURLProduction;
}

@end
