//
//  MainViewController.m
//  CharterProject
//
//  Created by alexandra blumenfeld on 6/8/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "MainViewController.h"
#import "AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"

static NSString *apiKey = @"apiKey=8d9c11062ab244c7ab15f44dcaa30c7b";

@interface MainViewController ()
@property NSMutableArray *halfDayCharters;
@property NSMutableArray *fullDayCharters;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.halfDayCharters = [NSMutableArray new];
    self.fullDayCharters = [NSMutableArray new];
    

}

- (void)getDataFromHalfDayCategory {
    
    NSString *strURL = [NSString stringWithFormat:@"https://api.rezdy.com/v1/categories/52961/products?%@", apiKey];
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *arrayData = [NSMutableArray new];
        arrayData = responseObject[@"products"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"failed http request");
    }];
    [operation start];
}




@end
