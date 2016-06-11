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
#import "CharterService.h"
#import "ProductsViewController.h"

static NSString *apiKey = @"apiKey=8d9c11062ab244c7ab15f44dcaa30c7b";

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *halfDayCharters;
@property NSMutableArray *fullDayCharters;
@property NSMutableArray *bedAndBoat;
@property NSMutableArray *nauticalOvernight;
@property NSArray *categotyIds;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categotyIds = @[@"52961" , @"50951" , @"87048", @"89968"];
    self.halfDayCharters = [NSMutableArray new];
    self.fullDayCharters = [NSMutableArray new];
    self.bedAndBoat = [NSMutableArray new];
    self.nauticalOvernight = [NSMutableArray new];
    [self getDataFromHalfDayCategory];

}

- (void)getDataFromHalfDayCategory {
    
    for (int i = 0; i <4; i++) {
        NSString *strURL = [NSString stringWithFormat:@"https://api.rezdy.com/v1/categories/%@/products?%@", [self.categotyIds objectAtIndex:i] ,apiKey];
        NSURL *url = [NSURL URLWithString:strURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSArray *arrayData = responseObject[@"products"];
            [self createCharterObject:arrayData];
            
        } failure:^(AFHTTPRequestOperation *operation, id responseObject){
            NSLog(@"failed http request");
        }];
        [operation start];
    }

}

- (void)createCharterObject:(NSArray*)arrayData {
    NSMutableArray *otraArray = [NSMutableArray new];
    
    for (NSDictionary *dict in arrayData) {
        CharterService *charterService = [[CharterService alloc]initWithDictionary:dict];
        [otraArray addObject:charterService];
    }
    
    [self.halfDayCharters addObject:[otraArray mutableCopy]];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.halfDayCharters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *array = [self.halfDayCharters objectAtIndex:indexPath.row];
//    cell.textLabel.text = ch.name;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    ProductsViewController *productVC = segue.destinationViewController;
    productVC.array = [self.halfDayCharters objectAtIndex:indexPath.row];

    

}






























@end
