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

@interface ProductsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString *categoryTitle;

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavBar];

  //  for (CharterService *charterservice in self.productsArray){
       // NSLog(@"%@", charterservice.name);
    //}
}

- (void)setNavBar {
    
    self.navigationController.navigationBar.hidden = NO;
    CharterService *charterService = [self.productsArray firstObject];
    if ([charterService.name containsString:@"Full Day"]) {
        self.categoryTitle = @"Full day Charters";
    } else if ([charterService.name containsString:@"Half-Day"]){
        self.categoryTitle = @"Half Day Charters";
    } else if ([charterService.name containsString:@"Nautical Overnight"]) {
        self.categoryTitle = @"Nautical Overnight";
    } else {
        self.categoryTitle = @"Bed & Boat";
    }
    self.title = self.categoryTitle;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CharterService *charterFavorite = [self.productsArray objectAtIndex:indexPath.row];
    [cell configureCellwithCharterService:charterFavorite];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productsArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.charterService = [self.productsArray objectAtIndex:indexPath.row];
}














@end
