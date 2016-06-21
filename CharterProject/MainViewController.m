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
#import "ContactViewController.h"
#import "UIColor+MainColor.h"


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
    [self createToolbar];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)createToolbar {
    
    CGRect frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 50, [[UIScreen mainScreen] bounds].size.width, 50);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:frame];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [toolbar setBarTintColor:[UIColor whiteColor]];
    [self.view addSubview:toolbar];
    
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chart"] style:UIBarButtonItemStylePlain target:self action:nil];
    [home setTintColor:[UIColor customMainColor]];
    [home setWidth:85];
    
    UIBarButtonItem *contact = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact"] style:UIBarButtonItemStylePlain target:self action:@selector(goToContact)];
    [contact setTintColor:[UIColor colorWithRed:0.4976 green:0.4952 blue:0.5 alpha:1.0]];
    [home setWidth:85];
    
    UIBarButtonItem *favorites = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorites"] style:UIBarButtonItemStylePlain target:self action:@selector(goToFavorites)];
    [favorites setTintColor:[UIColor colorWithRed:0.4976 green:0.4952 blue:0.5 alpha:1.0]];
    [favorites setWidth:85];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *buttonItems = [NSArray arrayWithObjects:spacer, home, spacer, contact , spacer, favorites,spacer, nil];
    [toolbar setItems:buttonItems];
}

- (void)goToContact {
    [self performSegueWithIdentifier:@"contact" sender:self];
}

- (void)goToFavorites {
    [self performSegueWithIdentifier:@"favorites" sender:self];
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
            [self alertUserNoInternetConnection];
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
    
    if ([segue.identifier isEqualToString:@"product"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        ProductsViewController *productVC = segue.destinationViewController;
        productVC.productsArray = [self.finalCategoryArray objectAtIndex:indexPath.row];
    } else{
    }
   
}

- (void)alertUserNoInternetConnection {
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        UIAlertController *noInternetAlert = [UIAlertController alertControllerWithTitle:@"No internet Connection"
                                                                            message:@"Whoops, can't connect Please check your internet connection"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           }];//save data block end

        [noInternetAlert addAction:dismiss];
        [self presentViewController:noInternetAlert animated:YES completion:nil];
    });
}



























@end
