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
#import "UIFont+CustomFont.h"
#import "CharterAPI.h"
#import "CustomToolBar.h"
#import "CommonUIConstants.h"
#import "Reachability.h"


@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSArray *categoryIds;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic, strong) CustomToolBar *toolBar;


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

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    

//    NSArray *fontFamilies = [UIFont familyNames];
//    
//    for (int i = 0; i < [fontFamilies count]; i++)
//    {
//        NSString *fontFamily = [fontFamilies objectAtIndex:i];
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
//        NSLog (@"%@: %@", fontFamily, fontNames);
//    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categoryIds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *categoryID = [self.categoryIds  objectAtIndex:indexPath.row];
    [cell configureCellWithString:categoryID];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"product"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        ProductsViewController *productVC = segue.destinationViewController;
        productVC.categoryID = [self.categoryIds objectAtIndex:indexPath.row];
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
    
   // [self configureLabel:self.statusLabel  withReachability:reachability];
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
         //   [self getDataFromApi];
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            label.hidden = YES;
          //  [self getDataFromApi];
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
