//
//  CharterAPI.m
//  CharterProject
//
//  Created by James Rochabrun on 9/20/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CharterAPI.h"
#import "CharterService.h"
#import "CharterFavorite.h"

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

+ (AFHTTPRequestOperation *)bookService:(CharterFavorite *)charter
                                success:(void (^)())success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    
    if  (!charter) {
        failure (nil,nil);
        return nil;
    }
    
    //https://api.rezdy.com/v1/bookings?apiKey=8d9c11062ab244c7ab15f44dcaa30c7b
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/bookings?%@", kHTTPProtocol, [CharterAPI URL], kapiKey];
    
   // NSLog(@"the post string is %@", urlString);
    NSDictionary *dict = @{
                                 @"customer": @{
                                     @"firstName": @"Hugo",
                                     @"lastName": @"Sterin",
                                     @"email": @"noreply@rezdy.com",
                                     @"phone": @"0282443060"
                                 },
                                 @"items": @[
                                           @{
                                               @"productCode": charter.productCode,
                                               @"startTimeLocal": @"2016-11-03 09:00:00",
                                               @"amount": @200,
                                               @"quantities": @[
                                                              @{
                                                                  @"optionLabel": @"Adult",
                                                                  @"value": @"2"
                                                              }
                                                              ],
                                               @"participants": @[
                                                               @{
                                                                    @"fields": @[
                                                                               @{
                                                                                   @"label": @"First Name",
                                                                                   @"value": @"Hugo"
                                                                               },
                                                                               @{
                                                                                   @"label": @"Last Name",
                                                                                   @"value": @"Sterin"
                                                                               }
                                                                               ]
                                                                },
                                       
                                                                ]
                                           }
                                           ],
                                 @"fields": @[
                                            @{
                                                @"label": @"Do you have any dietary requirements?",
                                                @"value": @"No, I have no requirements. "
                                            }
                                            ],
                                 @"comments": @"Special requirements go here",
                                 @"resellerComments": @"Your Agent voucher/redemption code should go here",
                                 @"payments": @[
                                              @{
                                                  @"type": @"CREDITCARD",
                                                  @"amount": @"200",
                                                  @"currency": @"USD",
                                                  @"date": @"2014-11-01T10:26:00Z",
                                                  @"label": @"Payment processed by RezdyDemoAgent"
                                              }
                                              ]
                                 };
    
    NSError *error;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:dict  options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    //NSDictionary *parameters = @{@"bookings":jsonString};
    //parameters
    NetworkManager *rm = [NetworkManager new];
    
    AFHTTPRequestOperation *op = [rm POST:urlString parameters:jsonString success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    return op;
}


+ (NSString *)URL {
    return kURLProduction;
}

@end
