//
//  FavoritesViewController.h
//  CharterProject
//
//  Created by James Rochabrun on 20-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomToolBar.h"
#import "CoreDataStack.h"


@interface FavoritesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate, CustomToolBarDelegate>

@end
