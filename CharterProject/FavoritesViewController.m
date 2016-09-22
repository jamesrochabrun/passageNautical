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
#import "Common.h"
#import "CommonUIConstants.h"

@interface FavoritesViewController ()<UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *wishLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *middleLabel;
@property (nonatomic, strong) UIButton *keepLookingButton;
@property (nonatomic, strong) UIImageView *shadow;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {

    [self createToolbar];
    [self.fetchedResultsController performFetch:nil];
    
    if (self.fetchedResultsController.sections.count <= 0) {
        [self setImageIfNotfavorites];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
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
    
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"sanfrancisco"];
    _shadow = [UIImageView new];
    _shadow.image = [UIImage imageNamed:@"shadowA"];
    
    _wishLabel = [UILabel new];
    _wishLabel.textColor = [UIColor whiteColor];
    _wishLabel.font = [UIFont regularFont:24];
    _wishLabel.text = @"Wish List";
    
    _textView = [UITextView new];
    _textView.userInteractionEnabled = NO;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.text = @"Find the perfect yacht for a special ocassion, like wedings, birthday celebration, or just to take your mettings with clientes or friends to the next level";
    _textView.textColor = [UIColor whiteColor];
    _textView.font = [UIFont regularFont:14];
    
    _middleLabel = [UILabel new];
    _middleLabel.textAlignment = NSTextAlignmentNatural;
    _middleLabel.text = @"You dont have any favorites ...yet";
    _middleLabel.textColor = [UIColor whiteColor];
    _middleLabel.font = [UIFont regularFont:20];
    _middleLabel.numberOfLines = 0;
    
    _keepLookingButton = [UIButton new];
    _keepLookingButton.layer.borderColor = [UIColor customMainColor].CGColor;
    _keepLookingButton.layer.borderWidth = 2.0f;
    [_keepLookingButton setTitle:@"Keep Looking" forState:UIControlStateNormal];
    [_keepLookingButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [_keepLookingButton addTarget:self action:@selector(onKeepLookingButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_keepLookingButton.titleLabel setFont:[UIFont regularFont:22]];
    
    [self.view addSubview:_imageView];
    [self.view addSubview:_shadow];
    [self.view addSubview:_wishLabel];
    [self.view addSubview:_textView];
    [self.view addSubview:_middleLabel];
    [self.view addSubview:_keepLookingButton];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    CGRect frame = _imageView.frame;
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.origin.y = kGeomHeightStatusBar;
    frame.size.height = height(self.view) - kGeomHeightToolBar;
    frame.size.width = width(self.view);
    _imageView.frame = frame;
    _shadow.frame = frame;
    
    [_wishLabel sizeToFit];
    frame = _wishLabel.frame;
    frame.origin.x = kGeomMarginBig;
    frame.origin.y = CGRectGetMinY(_imageView.frame) + kGeomMarginBig *2;
    _wishLabel.frame = frame;
    
    frame = _textView.frame;
    frame.size.width = width(self.view) *0.75;
    frame.size.height = 110;
    frame.origin.x = (width(self.view) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_wishLabel.frame) + kGeomMarginBig *2;
    _textView.frame = frame;
    
    [_middleLabel sizeToFit];
    frame = _middleLabel.frame;
    frame.origin.x = (width(self.view) - width(_middleLabel)) /2;
    frame.origin.y = CGRectGetMaxY(_textView.frame) + kGeomMarginMedium;
    _middleLabel.frame = frame;
    
    frame = _keepLookingButton.frame;
    frame.size.height = kGeomHeightBigbutton;
    frame.size.width = kGeomWidthBigButton;
    frame.origin.x = (width(self.view) - kGeomWidthBigButton) /2;
    frame.origin.y = CGRectGetMaxY(_middleLabel.frame) + kGeomMarginBig *2;
    _keepLookingButton.frame = frame;
}

#pragma coredata

- (NSFetchRequest *)entrylistfetchRequest {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CharterFavorite"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isFavorite == %d", YES];
    [fetchRequest setPredicate:predicate];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(tableView), 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 9, width(tableView), 32)];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kGeomHeaderHeightInSection;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

//updating the bool isFavorite
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Book Now!" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        NSLog(@"booking not available yet");
                                                            }];
    button.backgroundColor = [UIColor customMainColor];
    
    UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                     {
                                         
                                        
                                         CharterFavorite *charterfavorite = [self.fetchedResultsController objectAtIndexPath:indexPath];
                                         
                                         BOOL myBool = NO;
                                         charterfavorite.isFavorite = [NSNumber numberWithBool:myBool];
                                         
                                         CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
                                         [coreDataStack saveContext];
                                         
                                         if (self.fetchedResultsController.sections.count <= 0) {
                                             [self setImageIfNotfavorites];
                                         }
                                     }];
    button2.backgroundColor = [UIColor colorWithRed:1.0 green:0.435 blue:0.4153 alpha:1.0];
    
    return @[button, button2];
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
