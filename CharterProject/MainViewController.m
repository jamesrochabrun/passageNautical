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
#import "CategoryTableViewCell.h"

static NSString *apiKey = @"apiKey=8d9c11062ab244c7ab15f44dcaa30c7b";
static NSString *keyFromJSON = @"products";

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *finalCategoryArray;
@property NSArray *categoryIds;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.categoryIds = @[@"52961" , @"50951" , @"87048", @"89968"];
    self.finalCategoryArray = [NSMutableArray new];
    [self getDataFromApi];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;

}

- (void)getDataFromApi {
    
    for (int i = 0; i < self.categoryIds.count ; i++) {
        NSString *strURL = [NSString stringWithFormat:@"https://api.rezdy.com/v1/categories/%@/products?%@", [self.categoryIds objectAtIndex:i] ,apiKey];
        NSURL *url = [NSURL URLWithString:strURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSArray *arrayData = responseObject[keyFromJSON];
            
            [self createCharterObjectAndAddItToAnArrayCategory:arrayData];
            
        } failure:^(AFHTTPRequestOperation *operation, id responseObject){
            NSLog(@"failed http request");
        }];
        [operation start];
    }
}

- (void)createCharterObjectAndAddItToAnArrayCategory:(NSArray*)arrayData {
    
    NSMutableArray *categoryProductsArray = [NSMutableArray new];
    
    for (NSDictionary *dict in arrayData) {
        CharterService *charterService = [[CharterService alloc]initWithDictionary:dict];
        [categoryProductsArray addObject:charterService];
    }
    
    [self.finalCategoryArray addObject:[categoryProductsArray mutableCopy]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.finalCategoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *arr = [self.finalCategoryArray  objectAtIndex:indexPath.row];
    [cell configureCellwithArray:arr];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    ProductsViewController *productVC = segue.destinationViewController;
    productVC.productsArray = [self.finalCategoryArray objectAtIndex:indexPath.row];
}






























@end
