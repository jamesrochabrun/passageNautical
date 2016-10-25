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
#import "UILabel+Additions.h"

@interface ProductsViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *productsArray;
@property UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) CAGradientLayer *maskLayer;
@property NSString *categoryTitle;
@property (nonatomic, strong) UILabel *noInternetLabel;

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
     self.title = @"Nautical Overnight";
    _noInternetLabel = [UILabel labelWithText:@"No Internet Conection" withSize:12 inView:self.view];
    _noInternetLabel.backgroundColor = UIColorRGB(kColorYellowFlat);
    _noInternetLabel.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performUIUpdateIfInternet:)
                                                 name:@"internet"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performUIUpdateIfNoInternet:)
                                                 name:@"noInternet"
                                               object:nil];
    
    self.tableView.alpha = 0;
    [self getProductsFromCategoryID:_categoryID];
  
  //  for (CharterService *charterservice in self.productsArray){
       // NSLog(@"%@", charterservice.name);
    //}
}

- (void)performUIUpdateIfInternet:(NSNotification *)notification {
    
    NSLog(@"hay internet ");
    _noInternetLabel.hidden = YES;
    [self getProductsFromCategoryID:_categoryID];
}

- (void)performUIUpdateIfNoInternet:(NSNotification *)notification {
    
    NSLog(@"no hay internet");
    _noInternetLabel.hidden = NO;
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    CGRect frame = _noInternetLabel.frame;
    frame.size.height = 20;
    frame.size.width = width(self.view);
    frame.origin.x = 0;
    frame.origin.y = 0;
    _noInternetLabel.frame = frame;
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
            weakSelf.title = @"Bed & Boat Charters";
        }
    });
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

-(void)tableView:(UITableView *) tableView willDisplayCell:(ProductCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

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
            weakSelf.noInternetLabel.hidden = YES;
            if (_productsArray.count) {
                [UIView animateWithDuration:.5 animations:^{
                    weakSelf.tableView.alpha = 1;
                }];
            }
            [weakSelf.activityIndicator stopAnimating];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"getProducts returns OPERATION:%@, ERROR: %@" , operation, error);
        if (error) {
            __weak ProductsViewController *weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.noInternetLabel.hidden = NO;
                [weakSelf.activityIndicator stopAnimating];
            });
        };
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_tableView fadeTopAndBottomCellsOnTableViewScroll:_tableView withModifier:1.0];
}

-(void) viewWillDisappear:(BOOL)animated {
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        [UIView animateWithDuration:.25 animations:^{
            self.view.alpha = 0;
        }];
    }
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"internet" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"noInternet" object:nil];
}







@end
