//
//  ProductsViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductCell.h"
#import "CharterService.h"
#import "DetailViewController.h"
#import "CharterAPI.h"
#import "CommonUIConstants.h"

@interface ProductsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *productsArray;
@property UIActivityIndicatorView *activityIndicator;

@property NSString *categoryTitle;

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;

  //  for (CharterService *charterservice in self.productsArray){
       // NSLog(@"%@", charterservice.name);
    //}
}

- (void)setCategoryID:(NSString *)categoryID {
    
    if (_categoryID == categoryID) return;
    _categoryID = categoryID;
    
    __weak ProductsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([categoryID isEqualToString:kfullDayCategoryID]) {
            self.title = @"Full day Charters";
        } else if ([categoryID isEqualToString:khalfDayCategoryID]){
            weakSelf.title = @"Half Day Charters";
        } else if ([categoryID isEqualToString:knauticalOvernightCategoryId]) {
            weakSelf.title = @"Nautical Overnight";
        } else if ([categoryID isEqualToString:kbedAndBoatCategoryID]) {
            weakSelf.title = @"Bed & Boat";
        }
    });
    
    [self getProductsFromCategoryID:_categoryID];
}

- (void)startActivityIndicator {
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_activityIndicator];
    _activityIndicator.center = CGPointMake(width(self.view) /2,height(self.view) /2);
    
    __weak ProductsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.activityIndicator startAnimating];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    CharterService *charterFavorite = [self.productsArray objectAtIndex:indexPath.row];
//    [cell configureCellwithCharterService:charterFavorite];
    return cell;
}

-(void) tableView:(UITableView *) tableView willDisplayCell:(ProductCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    CharterService *charterFavorite = [self.productsArray objectAtIndex:indexPath.row];
    [cell configureCellwithCharterService:charterFavorite];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productsArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.charterService = [self.productsArray objectAtIndex:indexPath.row];
}

- (void)getProductsFromCategoryID:(NSString *)categoryID {
    
    [self startActivityIndicator];
        [CharterAPI getListOfServicesByID:categoryID success:^(NSArray *services) {
            _productsArray = services;
            __weak ProductsViewController *weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                [weakSelf.activityIndicator stopAnimating];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failure");
            if (error) {
                __weak ProductsViewController *weakSelf = self;
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf setLabelFortUserNoInternetConnection];
                      [weakSelf.activityIndicator stopAnimating];
                });
            };
        }];
}











@end
