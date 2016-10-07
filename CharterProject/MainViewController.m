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
#import "CustomToolBar.h"
#import "CommonUIConstants.h"
#import "Reachability.h"


static NSString *apiKey = @"apiKey=8d9c11062ab244c7ab15f44dcaa30c7b";
static NSString *keyFromJSON = @"products";

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *finalCategoryArray;
@property NSArray *categoryIds;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property UIActivityIndicatorView *activityIndicator;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic, strong) CustomToolBar *toolBar;
@property (nonatomic, strong) UILabel *statusLabel;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _toolBar = [CustomToolBar new];
    [_toolBar.home setTintColor:[UIColor customMainColor]];
    _toolBar.del = self;
    [self.view addSubview:_toolBar];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBar.hidden = YES;
    self.categoryIds = @[khalfDayCategoryID, kfullDayCategoryID,knauticalOvernightCategoryId,kbedAndBoatCategoryID];
    self.finalCategoryArray = [NSMutableArray new];
    
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 30)];
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.center = CGPointMake(width(self.view)/2, height(self.view)/2);
    _statusLabel.text = @"no internet connection";
    _statusLabel.textColor = [UIColor customTextColor];
    _statusLabel.font = [UIFont regularFont:22];
    _statusLabel.hidden = YES;
    [self.view addSubview:_statusLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
    [self getDataFromApi];
    [self startActivityIndicator];
    
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
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_activityIndicator];
    _activityIndicator.center = CGPointMake(width(self.view) /2,height(self.view) /2);
    
    __weak MainViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.activityIndicator startAnimating];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)goToContact {
    [self performSegueWithIdentifier:@"contact" sender:self];
}

- (void)goToFavorites {
    [self performSegueWithIdentifier:@"favorites" sender:self];
}

- (void)goToHome {
    NSLog(@"I am alredy at home :) ");
}

- (void)getDataFromApi {
    
    for (int i = 0; i < self.categoryIds.count ; i++) {
        
        NSString *categoryID = [self.categoryIds objectAtIndex:i];
        
        [CharterAPI getListOfServicesByID:categoryID success:^(NSArray *services) {
            
            [_finalCategoryArray addObject:services];
            
            __weak MainViewController *weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                [weakSelf.activityIndicator stopAnimating];
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failure");
            
            if (error) {
                __weak MainViewController *weakSelf = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.activityIndicator stopAnimating];
                });
            };
        }];
    }
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

//make more research
//-(void) tableView:(UITableView *) tableView willDisplayCell:(CategoryTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//  
//}

#pragma  Reachability
/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    
    [self configureLabel:self.statusLabel  withReachability:reachability];
}

- (void)configureLabel:(UILabel *)label withReachability:(Reachability *)reachability {
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    
    switch (netStatus)
    {
        case NotReachable:        {
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            label.hidden = NO;
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            label.hidden = YES;
            [self getDataFromApi];
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            label.hidden = YES;
            [self getDataFromApi];
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
    label.text = statusString;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

























@end
