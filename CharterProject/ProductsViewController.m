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

@interface ProductsViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBar];
    NSLog(@"the count is %lu" , self.productsArray.count);
}

- (void)setNavBar {
    self.navigationController.navigationBar.hidden = NO;
    CharterService *charterService = [self.productsArray firstObject];
    if ([charterService.name containsString:@"Full Day"]) {
        self.title = @"Full day Charters";
    } else if ([charterService.name containsString:@"Half-Day"]){
        self.title = @"Half Day Charters";
    } else if ([charterService.name containsString:@"Nautical Overnight"]) {
        self.title = @"Nautical Overnight";
    } else {
        self.title = @"Bed & Boat";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CharterService *charterService = [self.productsArray objectAtIndex:indexPath.row];
    [cell configureCellwithCharterService:charterService];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productsArray.count;
}



@end