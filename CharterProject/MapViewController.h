//
//  MapViewController.h
//  CharterProject
//
//  Created by James Rochabrun on 21-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharterService;
@class CharterFavorite;


@interface MapViewController : UIViewController
@property CharterService *charterService;
@property CharterFavorite *charterFavorite;


@end
