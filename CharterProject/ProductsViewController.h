//
//  ProductsViewController.h
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharterService.h"

@interface ProductsViewController : UIViewController
@property CharterService *charterService;
@property NSArray *productsArray;
@end
