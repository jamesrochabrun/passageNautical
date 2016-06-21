//
//  ContatViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 18-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ContactViewController.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"

@interface ContactViewController()

@end

@implementation ContactViewController


- (void)viewDidLoad {
    [self displayContentInViewController];
    [self createToolbar];
}

- (void)createToolbar {
    
    CGRect frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 50, [[UIScreen mainScreen] bounds].size.width, 50);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:frame];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [toolbar setBarTintColor:[UIColor whiteColor]];
    [self.view addSubview:toolbar];
    
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorites"] style:UIBarButtonItemStylePlain target:self action:@selector(goToHome)];
    [home setTintColor:[UIColor customTextColor]];
    [home setWidth:85];

    UIBarButtonItem *contact = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact"] style:UIBarButtonItemStylePlain target:self action:nil];
    [contact setTintColor:[UIColor customMainColor]];
    [home setWidth:85];
    
    UIBarButtonItem *favorites = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorites"] style:UIBarButtonItemStylePlain target:self action:@selector(goToFavorites)];
    [favorites setTintColor:[UIColor customTextColor]];
    [favorites setWidth:85];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *buttonItems = [NSArray arrayWithObjects:spacer, home, spacer, contact , spacer, favorites,spacer, nil];
    [toolbar setItems:buttonItems];
}

- (void)goToHome {
    [self performSegueWithIdentifier:@"home" sender:self];
}

- (void)goToFavorites {
    [self performSegueWithIdentifier:@"favorites" sender:self];
}


- (void)displayContentInViewController {

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *2.7)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height*2)];
    [scrollView addSubview:view];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height/2.2)];
    imageView.image = [UIImage imageNamed:@"debbie"];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    [view addSubview:imageView];

    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 21)];
    [contactLabel setCenter:(CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/1.6))];
    contactLabel.textAlignment = NSTextAlignmentCenter;
    contactLabel.font = [UIFont regularFont:28];
    contactLabel.textColor = [UIColor whiteColor];
    contactLabel.text = @"Contact";
    [imageView addSubview:contactLabel];
    
    UIButton *callButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 210, 40)];
    [callButton setTitle:@"Call" forState:UIControlStateNormal];
    [callButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [callButton addTarget:self action:@selector(onCallButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [callButton setCenter:(CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/1.4))];
    callButton.layer.borderColor = [UIColor customMainColor].CGColor;
    callButton.layer.borderWidth = 2.0f;
    [callButton.titleLabel setFont:[UIFont mediumFont:22]];
    [imageView addSubview:callButton];
    
    UIButton *mailButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 210, 40)];
    [mailButton setTitle:@"Send us Email" forState:UIControlStateNormal];
    [mailButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [mailButton addTarget:self action:@selector(onMailButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [mailButton setCenter:(CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/1.20))];
    mailButton.layer.borderColor = [UIColor customMainColor].CGColor;
    mailButton.layer.borderWidth = 2.0f;
    [mailButton.titleLabel setFont:[UIFont mediumFont:22]];
    [imageView addSubview:mailButton];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 220, 70)];
    [logoImage setCenter:CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height + 60)];
    logoImage.contentMode = UIViewContentModeScaleToFill;
    logoImage.image = [UIImage imageNamed:@"logo"];
    logoImage.contentMode = UIViewContentModeScaleAspectFit;
    [imageView addSubview:logoImage];
    
    UITextView *descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width * 0.75, 700)];
    descriptionTextView.showsVerticalScrollIndicator = NO;
    descriptionTextView.userInteractionEnabled = NO;
    [descriptionTextView setCenter:CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height +450)];
    descriptionTextView.font = [UIFont regularFont:15];
    descriptionTextView.textColor = [UIColor customTextColor];
    descriptionTextView.scrollEnabled = NO;
    descriptionTextView.text= @"Passage Nautical is a San Francisco Bay Area based full service yacht dealer. We are the exclusive yacht dealer for Beneteau sailboats and powerboats, premier Lagoon catamarans and offer the largest selection of used boats in the Bay Area. We are an ASA (American Sailing Association) school, US Powerboating training facility and charter boat rental facility. What sets Passage Nautical apart from the rest is our full service approach to helping you enjoy the boating lifestyle, from our world class yacht sales division and our award-winning Service Department which offers repairs, installation, concierge services and a lifetime service relationship, to our power and sail training academy, educational seminar series and world-class yacht sales division.  We help people go boating. We make yacht financing easy and offer complete insurance services. Our Boat-As-A-Business workshop informs you how to receive tax savings through yacht charter placement programs. We host monthly test rides, educational workshops and other VIP events about the boating lifestyle. For 30+ years, we have been making people’s boating dreams a reality. Let us help you with yours.";
    [imageView addSubview:descriptionTextView];
}


- (void)onCallButtonPressed {
    NSLog(@"call");
}

- (void)onMailButtonPressed {
    NSLog(@"email");
}










@end
