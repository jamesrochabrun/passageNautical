//
//  CustomToolBar.m
//  CharterProject
//
//  Created by James Rochabrun on 9/22/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CustomToolBar.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"
#import "CommonUIConstants.h"

@implementation CustomToolBar

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
        [self setBarTintColor:[UIColor whiteColor]];
        
        _home = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chart"] style:UIBarButtonItemStylePlain target:self action:@selector(goToHome)];
        [_home setTintColor:[UIColor toolBarButtonColor]];
        [_home setWidth:kGeomWidthToolBarButton];
        
        _contact = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact"] style:UIBarButtonItemStylePlain target:self action:@selector(goToContact)];
        [_contact setTintColor:[UIColor toolBarButtonColor]];
        [_home setWidth:kGeomWidthToolBarButton];
        
        _favorites = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorites"] style:UIBarButtonItemStylePlain target:self action:@selector(goToFavorites)];
        [_favorites setTintColor:[UIColor toolBarButtonColor]];
        [_favorites setWidth:kGeomWidthToolBarButton];
        
        _spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        NSArray *buttonItems = [NSArray arrayWithObjects:_spacer, _home, _spacer, _contact , _spacer, _favorites, _spacer, nil];
        [self setItems:buttonItems];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 50, [[UIScreen mainScreen] bounds].size.width, 50);
    self.frame = frame;
    
}


- (void)goToContact {
    [self.del goToContact];
}

- (void)goToFavorites {
    [self.del goToFavorites];
}

- (void)goToHome {
    [self.del goToHome];
}




@end
