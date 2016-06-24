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
#import "CoreDataStack.h"
#import "CharterFavorite.h"

@interface ProductsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL isItFavorite;
@property NSString *categoryTitle;
@property NSMutableArray *productsManagedObjectsArray;

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavBar];
    
     [self loadProducts];
    if (self.productsManagedObjectsArray.count < 1) {
        [self saveInCoreDataWithArrayOfObjects:self.productsArray];
    }
    
    for (CharterService *charterservice in self.productsArray){
        NSLog(@"%@", charterservice.name);
    }
}

- (void)saveInCoreDataWithArrayOfObjects:(NSArray*)array {
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    self.productsManagedObjectsArray = [NSMutableArray new];
    
    for (CharterService *charterService in array) {
        CharterFavorite *charterFavorite = [NSEntityDescription insertNewObjectForEntityForName:@"CharterFavorite" inManagedObjectContext:coreDataStack.managedObjectContext];
        charterFavorite.name = charterService.name;
        charterFavorite.currency = charterService.currency;
        charterFavorite.advertisedPrice = charterService.advertisedPrice;
        charterFavorite.charterDescription = charterService.charterDescription;
        charterFavorite.shortCharterDescription = charterService.shortDescription;
        charterFavorite.latitude = [NSString stringWithFormat:@"%@",charterService.latitude];
        charterFavorite.longitude = [NSString stringWithFormat:@"%@",charterService.longitude];
        charterFavorite.durationMinutes = charterService.durationMinutes;
        charterFavorite.generalTerms = charterService.generalTerms;
        charterFavorite.productCode = charterService.productCode;
        charterFavorite.category = self.categoryTitle;
        
        BOOL myBool = NO;
        charterFavorite.isFavorite = [NSNumber numberWithBool:myBool];
        charterFavorite.date = [[NSDate date] timeIntervalSince1970];
        
        NSDictionary *imagesDictionary = [charterService.images firstObject];
        NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
        NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        charterFavorite.imageURL = itemUrlWithNoSpaces;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:charterService.bookingFields];
        charterFavorite.bookingFields = data;
        [self.productsManagedObjectsArray addObject:charterFavorite];
    }
    [coreDataStack saveContext];
}

-(void)loadProducts {
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CharterFavorite"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"advertisedPrice" ascending:NO]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", self.title];
    [request setPredicate:predicate];
    
    NSError *error;
    //the & is using the addres of error
    self.productsManagedObjectsArray = [[coreDataStack.managedObjectContext executeFetchRequest:request error:&error]mutableCopy];
    if(error == nil){
        [self.tableView reloadData];
    }else{
        NSLog(@"Error: %@", error);
    }
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
    CharterFavorite *charterFavorite = [self.productsManagedObjectsArray objectAtIndex:indexPath.row];
    [cell configureCellwithCharterFavorite:charterFavorite];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productsManagedObjectsArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.charterFavorite = [self.productsManagedObjectsArray objectAtIndex:indexPath.row];
}














@end
