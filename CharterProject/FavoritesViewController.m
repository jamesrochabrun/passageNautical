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

@interface FavoritesViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *placeHolderImage;
@property (weak, nonatomic) IBOutlet UIButton *keepLookingButton;


@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [self createToolbar];
    [self customizeContentInView];

}

- (void)customizeContentInView {
    self.placeHolderImage.image = [UIImage imageNamed:@"sanfrancisco"];
    self.keepLookingButton.layer.borderColor = [UIColor customMainColor].CGColor;
    self.keepLookingButton.layer.borderWidth = 2.0f;
    [self.keepLookingButton.titleLabel setFont:[UIFont regularFont:20]];
    [self.keepLookingButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    
}


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

- (void)goToHome {
    [self performSegueWithIdentifier:@"home" sender:self];
}

- (void)goToContact {
    [self performSegueWithIdentifier:@"contact" sender:self];
}

- (IBAction)keepLooking:(UIButton *)sender {
    [self performSegueWithIdentifier:@"home" sender:self];

}







@end
