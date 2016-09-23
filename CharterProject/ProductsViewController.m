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
#import "Charter.h"

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
    
  //  for (CharterService *charterservice in self.productsArray){
       // NSLog(@"%@", charterservice.name);
    //}
}

- (void)saveInCoreDataWithArrayOfObjects:(NSArray *)array {
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    _productsManagedObjectsArray = [NSMutableArray new];
    
    for (CharterService *charterService in array) {
        Charter *charter = [NSEntityDescription insertNewObjectForEntityForName:@"Charter" inManagedObjectContext:coreDataStack.managedObjectContext];
        charter.name = charterService.name;
        charter.currency = charterService.currency;
        charter.advertisedPrice = charterService.advertisedPrice;
        charter.charterDescription = charterService.charterDescription;
        charter.shortCharterDescription = charterService.shortDescription;
        charter.latitude = [NSString stringWithFormat:@"%@",charterService.latitude];
        charter.longitude = [NSString stringWithFormat:@"%@",charterService.longitude];
        charter.durationMinutes = charterService.durationMinutes;
        charter.generalTerms = charterService.generalTerms;
        charter.productCode = charterService.productCode;
        
        //here I define the title of each category:
        //- first I set the first item of the array and with an if statement i define the title if contains a string related to it [self setNavBar];
        //- second, i set the category to all the products in the array passed to the title that i set using the method [sel setNavBar]
        //- finally I just make a predicate using self.title or self.categoryTitle  , without coredata thats not possible
        charter.category = self.categoryTitle;
        
        BOOL myBool = NO;
        charter.isFavorite = [NSNumber numberWithBool:myBool];
        charter.date = [[NSDate date] timeIntervalSince1970];
        
        NSDictionary *imagesDictionary = [charterService.images firstObject];
        NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
        NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        charter.imageURL = itemUrlWithNoSpaces;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:charterService.bookingFields];
        charter.bookingFields = data;
        [self.productsManagedObjectsArray addObject:charter];
    }
    [coreDataStack saveContext];
}

-(void)loadProducts {
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Charter"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"advertisedPrice" ascending:NO]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", self.title];
    [request setPredicate:predicate];
    
    NSError *error;
    //the & is using the addres of error
    _productsManagedObjectsArray = [[coreDataStack.managedObjectContext executeFetchRequest:request error:&error]mutableCopy];
    if(error == nil){
        
        __weak ProductsViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
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
    Charter *charter = [self.productsManagedObjectsArray objectAtIndex:indexPath.row];
    [cell configureCellwithCharter:charter];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productsManagedObjectsArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.charter = [self.productsManagedObjectsArray objectAtIndex:indexPath.row];
}














@end
