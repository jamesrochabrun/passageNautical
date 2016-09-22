//
//  CustomToolBar.h
//  CharterProject
//
//  Created by James Rochabrun on 9/22/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomToolBarDelegate

- (void)goToContact;
- (void)goToFavorites;
- (void)goToHome;

@end

@interface CustomToolBar : UIToolbar

@property (nonatomic, weak) id<CustomToolBarDelegate>del;
@property (nonatomic, strong) UIBarButtonItem *home;
@property (nonatomic, strong) UIBarButtonItem *contact;
@property (nonatomic, strong) UIBarButtonItem *favorites;
@property (nonatomic, strong) UIBarButtonItem *spacer;


@end
