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
#import "UITableView+Additions.h"

@interface ProductsViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *productsArray;
@property UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) CAGradientLayer *maskLayer;

@property NSString *categoryTitle;

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
     self.title = @"Nautical Overnight";
  //  for (CharterService *charterservice in self.productsArray){
       // NSLog(@"%@", charterservice.name);
    //}
}


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}



- (void)setCategoryID:(NSString *)categoryID {
    
    if (_categoryID == categoryID) return;
    _categoryID = categoryID;
    
    __weak ProductsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_categoryID isEqualToString:kfullDayCategoryID]) {
            self.title = @"Full day Charters";
        } else if ([_categoryID isEqualToString:khalfDayCategoryID]){
            weakSelf.title = @"Half Day Charters";
        } else if ([_categoryID isEqualToString:knauticalOvernightCategoryId]) {
            weakSelf.title = @"Nautical Overnight";
        } else if ([_categoryID isEqualToString:kbedAndBoatCategoryID]) {
            weakSelf.title = @"Bed & Boat";
        }
    });
    
    [self getProductsFromCategoryID:_categoryID];
}

- (void)startActivityIndicator {
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_activityIndicator];
    _activityIndicator.center = CGPointMake(self.view.center.x,self.view.center.y - kGeomMarginBig);
    
    __weak ProductsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.activityIndicator startAnimating];
    });
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_tableView fadeTopAndBottomCellsOnTableViewScroll:_tableView withModifier:1.0];
}








@end
