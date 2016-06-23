//
//  FavoritesViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 20-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "FavoritesViewController.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"
#import "FavoriteCell.h"
#import "CoreDataStack.h"
#import "CharterFavorite.h"
#import "DetailViewController.h"

@interface FavoritesViewController ()<UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    self.navigationController.navigationBar.hidden = YES;

    [self createToolbar];
    [self.fetchedResultsController performFetch:nil];
    
    if (self.fetchedResultsController.sections.count <= 0) {
        [self setImageIfNotfavorites];
    }
}

#pragma content layout in code
- (void)createToolbar {
    
    CGRect frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 50, [[UIScreen mainScreen] bounds].size.width, 50);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:frame];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [toolbar setBarTintColor:[UIColor whiteColor]];
    [self.view addSubview:toolbar];
    
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chart"] style:UIBarButtonItemStylePlain target:self action:@selector(goToHome)];
    [home setTintColor:[UIColor colorWithRed:0.4976 green:0.4952 blue:0.5 alpha:1.0]];
    [home setWidth:85];
    
    UIBarButtonItem *contact = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact"] style:UIBarButtonItemStylePlain target:self action:@selector(goToContact)];
    [contact setTintColor:[UIColor colorWithRed:0.4976 green:0.4952 blue:0.5 alpha:1.0]];
    [home setWidth:85];
    
    UIBarButtonItem *favorites = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorites"] style:UIBarButtonItemStylePlain target:self action:nil];
    [favorites setTintColor:[UIColor customMainColor]];
    [favorites setWidth:85];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *buttonItems = [NSArray arrayWithObjects:spacer, home, spacer, contact , spacer, favorites,spacer, nil];
    [toolbar setItems:buttonItems];
}

- (void)setImageIfNotfavorites  {
    
    self.tableView.hidden = YES;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-70)];
    imageview.image = [UIImage imageNamed:@"sanfrancisco"];
    UIImageView *shadow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-70)];
    shadow.image = [UIImage imageNamed:@"shadowA"];
    
    UILabel *wishLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    wishLabel.center = CGPointMake(self.view.frame.size.width/2.5, self.view.frame.size.height*0.20);
    wishLabel.textColor = [UIColor whiteColor];
    wishLabel.font = [UIFont regularFont:24];
    wishLabel.text = @"Wish List";
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.75, 340)];
    textView.backgroundColor = [UIColor clearColor];
    textView.center = CGPointMake(imageview.frame.size.width/2, imageview.frame.size.height*0.70);
    textView.text = @"Find the perfect yacht for a special ocassion, like wedings, birthday celebration, or just to take your mettings with clientes or friends to the next level";
    textView.textColor = [UIColor whiteColor];
    textView.font = [UIFont regularFont:14];
    
    UILabel *middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.75 , 50)];
    middleLabel.textAlignment = NSTextAlignmentNatural;
    middleLabel.center = CGPointMake(imageview.frame.size.width/2, imageview.frame.size.height*0.6);
    middleLabel.text = @"You dont have any favorites..yet";
    middleLabel.textColor = [UIColor whiteColor];
    middleLabel.font = [UIFont regularFont:22];
    middleLabel.numberOfLines = 2;
    
    UIButton *KeepLookingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 220, 55)];
    KeepLookingButton.center = CGPointMake(imageview.frame.size.width/2, imageview.frame.size.height*0.77);
    KeepLookingButton.layer.borderColor = [UIColor customMainColor].CGColor;
    KeepLookingButton.layer.borderWidth = 2.0f;
    [KeepLookingButton setTitle:@"Keep Looking" forState:UIControlStateNormal];
    [KeepLookingButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [KeepLookingButton addTarget:self action:@selector(onKeepLookingButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [KeepLookingButton.titleLabel setFont:[UIFont regularFont:22]];
    
    [self.view addSubview:imageview];
    [self.view addSubview:shadow];
    [self.view addSubview:wishLabel];
    [self.view addSubview:textView];
    [self.view addSubview:middleLabel];
    [self.view addSubview:KeepLookingButton];

}

#pragma coredata 

- (NSFetchRequest *)entrylistfetchRequest {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CharterFavorite"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    return  fetchRequest;
}

- (NSFetchedResultsController*)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    CoreDataStack *coreDataStack = [CoreDataStack  defaultStack];
    NSFetchRequest *fetchRequest = [self entrylistfetchRequest];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:@"sectionName" cacheName:nil];
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        default:
            break;
    }
}

#pragma tableViewMethods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CharterFavorite *charterFavorite = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureCellForFavorite:charterFavorite];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.fetchedResultsController.sections.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 9, tableView.frame.size.width, 32)];
    [label setFont:[UIFont mediumFont:15]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    //NSFETCHRESULTCONTROLLER
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    //this is setted in CharterFavorite+CoreDataProperties.m
    NSString *sectionName = [sectionInfo name];
    ///////////////////////////////////////////
    [label setText:[NSString stringWithFormat:@"favorite on %@" ,sectionName]];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor customMainColor]]; 
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

//deleting coredata method
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CharterFavorite *charterfavorite = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [[coreDataStack managedObjectContext] deleteObject:charterfavorite];
    [coreDataStack saveContext];
}



#pragma segues

- (void)goToHome {
    [self performSegueWithIdentifier:@"home" sender:self];
}

- (void)goToContact {
    [self performSegueWithIdentifier:@"contact" sender:self];
}

- (void)onKeepLookingButtonTapped {

    [self performSegueWithIdentifier:@"home" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual :@"charterFavorite"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.charterFavorite = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
    }
}







@end