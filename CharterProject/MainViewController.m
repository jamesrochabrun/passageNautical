//
//  MainViewController.m
//  CharterProject
//
//  Created by alexandra blumenfeld on 6/8/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//
//this is a test for github

#import "MainViewController.h"
#import "AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "CharterService.h"
#import "ProductsViewController.h"
#import "CategoryTableViewCell.h"
#import "ContactViewController.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"
#import "CharterAPI.h"



static NSString *apiKey = @"apiKey=8d9c11062ab244c7ab15f44dcaa30c7b";
static NSString *keyFromJSON = @"products";

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *finalCategoryArray;
@property NSArray *categoryIds;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property UIActivityIndicatorView *activityIndicator;
@property UIToolbar *toolBar;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBar.hidden = YES;
    self.categoryIds = @[@"52961" , @"50951" , @"87048", @"89968"];
    self.finalCategoryArray = [NSMutableArray new];
    [self getDataFromApi];
    [self createToolbar];
    [self startActivityIndicator];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    
//    NSArray *fontFamilies = [UIFont familyNames];
//    
//    for (int i = 0; i < [fontFamilies count]; i++)
//    {
//        NSString *fontFamily = [fontFamilies objectAtIndex:i];
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
//        NSLog (@"%@: %@", fontFamily, fontNames);
//    }
}

- (void)startActivityIndicator {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview: self.activityIndicator];
    self.activityIndicator.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/2);
    [self.activityIndicator startAnimating];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)createToolbar {
    
    CGRect frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 50, [[UIScreen mainScreen] bounds].size.width, 50);
    self.toolBar = [[UIToolbar alloc] initWithFrame:frame];
    [self.toolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self.toolBar setBarTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.toolBar];
    
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
    [self.toolBar setItems:buttonItems];
}

- (void)goToContact {
    [self performSegueWithIdentifier:@"contact" sender:self];
}

- (void)goToFavorites {
    [self performSegueWithIdentifier:@"favorites" sender:self];
}

- (void)getDataFromApi {
    
    for (int i = 0; i < self.categoryIds.count ; i++) {
        
        NSString *categoryID = [self.categoryIds objectAtIndex:i];
        
        [CharterAPI getListOfServicesByID:categoryID success:^(NSArray *services) {
            
            NSLog(@" the count is %lu", services.count);
            NSLog(@"the services are %@", services);
            [self.finalCategoryArray addObject:services];
            
            NSLog(@"the count of final array is %lu", _finalCategoryArray.count);
            
            __weak MainViewController *weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                [weakSelf.activityIndicator stopAnimating];
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failure");
            
            [self setLabelFortUserNoInternetConnection];
            [self.activityIndicator stopAnimating];
        }];
    }
}

- (void)createCharterObjectAndAddItToAnArrayCategory:(NSArray*)arrayData {
    
    NSMutableArray *categoryProductsArray = [NSMutableArray new];
    
    for (NSDictionary *dict in arrayData) {
        CharterService *charterService = [[CharterService alloc] initWithDictionary:dict];
        [categoryProductsArray addObject:charterService];
    }
    [self.finalCategoryArray addObject:[categoryProductsArray mutableCopy]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.activityIndicator stopAnimating];
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


- (void)setLabelFortUserNoInternetConnection {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, self.view
                               .frame.size.height/2);
    label.text = @"no internet connection";
    label.textColor = [UIColor customTextColor];
    label.font = [UIFont regularFont:22];
    [self.view addSubview:label];
    self.toolBar.userInteractionEnabled = NO;
}



























@end
