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

+ (AFHTTPRequestOperation *)getListOfServicesByID:(NSUInteger)listID
                                          success:(void (^)(NSArray *services))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/categories/%lu/products?%@", kHTTPProtocol, [CharterAPI URL], (unsigned long)listID, kapiKey];
    
    NetworkManager *nm = [NetworkManager new];
    
    AFHTTPRequestOperation *op = [nm GET:urlString parameters:nil success:^(id responseObject) {
        

       NSArray *arrayData = responseObject[keyFromJSON];

        NSMutableArray *categoryProductsArray = [NSMutableArray new];
        
        for (id dict in arrayData) {
            CharterService *charterService = [[CharterService alloc]initWithDictionary:dict];
            [categoryProductsArray addObject:charterService];
        }
        
        success(categoryProductsArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
                                  
    return op;
}


+ (NSString *)URL {
    return kURLProduction;
}

@end
