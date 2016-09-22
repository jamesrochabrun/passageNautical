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
#import <MessageUI/MessageUI.h>
#import "Common.h"
#import "CommonUIConstants.h"


@interface ContactViewController()<MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) UIView *statusBarViewBackground;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *contactLabel;
@property (nonatomic, strong) UIButton *callButton;
@property (nonatomic, strong) UIButton *mailButton;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UITextView *textView;

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
    
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chart"] style:UIBarButtonItemStylePlain target:self action:@selector(goToHome)];
    [home setTintColor:[UIColor colorWithRed:0.4976 green:0.4952 blue:0.5 alpha:1.0]];
    [home setWidth:85];

    UIBarButtonItem *contact = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact"] style:UIBarButtonItemStylePlain target:self action:nil];
    [contact setTintColor:[UIColor customMainColor]];
    [home setWidth:85];
    
    UIBarButtonItem *favorites = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorites"] style:UIBarButtonItemStylePlain target:self action:@selector(goToFavorites)];
    [favorites setTintColor:[UIColor colorWithRed:0.4976 green:0.4952 blue:0.5 alpha:1.0]];
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
    
    _statusBarViewBackground = [UIView new];
    _statusBarViewBackground.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_statusBarViewBackground];

    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_scrollView];
    _scrollView.showsVerticalScrollIndicator = NO;

    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"debbie"];
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [_scrollView addSubview:_imageView];

    _contactLabel = [UILabel new];
    _contactLabel.textAlignment = NSTextAlignmentCenter;
    _contactLabel.font = [UIFont regularFont:28];
    _contactLabel.textColor = [UIColor whiteColor];
    _contactLabel.text = @"Contact";
    [_scrollView addSubview:_contactLabel];
    
    _callButton = [UIButton new];
    [_callButton setTitle:@"Call" forState:UIControlStateNormal];
    [_callButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [_callButton addTarget:self action:@selector(onCallButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _callButton.layer.borderColor = [UIColor customMainColor].CGColor;
    _callButton.layer.borderWidth = 2.0f;
    [_callButton.titleLabel setFont:[UIFont mediumFont:22]];
    [_scrollView addSubview:_callButton];
    
    _mailButton = [UIButton new];
    [_mailButton setTitle:@"Send us Email" forState:UIControlStateNormal];
    [_mailButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [_mailButton addTarget:self action:@selector(onMailButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _mailButton.layer.borderColor = [UIColor customMainColor].CGColor;
    _mailButton.layer.borderWidth = 2.0f;
    [_mailButton.titleLabel setFont:[UIFont mediumFont:22]];
    [_scrollView addSubview:_mailButton];
    
    _logoView = [UIImageView new];
    _logoView.contentMode = UIViewContentModeScaleToFill;
    _logoView.image = [UIImage imageNamed:@"logo"];
    _logoView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_logoView];
    
    _textView = [UITextView new];
    _textView.showsVerticalScrollIndicator = NO;
    _textView.userInteractionEnabled = NO;
    _textView.font = [UIFont regularFont:15];
    _textView.textColor = [UIColor customTextColor];
    _textView.scrollEnabled = NO;
    _textView.text= @"Passage Nautical is a San Francisco Bay Area based full service yacht dealer. We are the exclusive yacht dealer for Beneteau sailboats and powerboats, premier Lagoon catamarans and offer the largest selection of used boats in the Bay Area. We are an ASA (American Sailing Association) school, US Powerboating training facility and charter boat rental facility. What sets Passage Nautical apart from the rest is our full service approach to helping you enjoy the boating lifestyle, from our world class yacht sales division and our award-winning Service Department which offers repairs, installation, concierge services and a lifetime service relationship, to our power and sail training academy, educational seminar series and world-class yacht sales division.  We help people go boating. We make yacht financing easy and offer complete insurance services. Our Boat-As-A-Business workshop informs you how to receive tax savings through yacht charter placement programs. We host monthly test rides, educational workshops and other VIP events about the boating lifestyle. For 30+ years, we have been making people’s boating dreams a reality. Let us help you with yours.";
    [_scrollView addSubview:_textView];
    

}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    CGRect frame = _statusBarViewBackground.frame;
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.origin.y = CGRectGetMinY(self.view.frame);
    frame.size.width = width(self.view);
    frame.size.height = kGeomHeightStatusBar;
    _statusBarViewBackground.frame = frame;
    
    frame = _scrollView.frame;
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.origin.y = CGRectGetMaxY(_statusBarViewBackground.frame);
    frame.size.width = width(self.view);
    frame.size.height = height(self.view);
    _scrollView.frame = frame;
    
    frame = _imageView.frame;
    frame.origin.y = CGRectGetMinY(self.view.frame);
    frame.origin.x = CGRectGetMinX(_scrollView.frame);
    frame.size.width = width(_scrollView);
    frame.size.height = height(_scrollView);
    _imageView.frame = frame;
    
    frame = _contactLabel.frame;
    frame.size.width = width(self.view);
    frame.size.height = kGeomHeightLabel;
    frame.origin.x = CGRectGetMinX(_imageView.frame);
    frame.origin.y = (height(_imageView) - kGeomHeightLabel) /2;
    _contactLabel.frame = frame;
    
    frame = _callButton.frame;
    frame.size.width = kGeomWidthBigButton;
    frame.size.height = kGeomHeightBigbutton;
    frame.origin.x = (width(_imageView) - kGeomWidthBigButton) /2;
    frame.origin.y = CGRectGetMaxY(_contactLabel.frame);
    _callButton.frame = frame;
    
    frame = _mailButton.frame;
    frame.size.width = kGeomWidthBigButton;
    frame.size.height = kGeomHeightBigbutton;
    frame.origin.x = (width(_imageView) - kGeomWidthBigButton) /2;
    frame.origin.y = CGRectGetMaxY(_callButton.frame);
    _mailButton.frame = frame;
    
    frame = _logoView.frame;
    frame.size.width = 220;
    frame.size.height = 70;
    frame.origin.x = (width(_scrollView) - 220) /2;
    frame.origin.y = CGRectGetMaxY(_imageView.frame);
    _logoView.frame = frame;
    
    
    frame = _textView.frame;
    frame.size.width = width(self.view) * 0.75;
    frame.size.height = [_textView sizeThatFits:CGSizeMake(frame.size.width, FLT_MAX)].height;
    frame.origin.y = CGRectGetMaxY(_logoView.frame);
    frame.origin.x = (width(self.view) - width(self.view) *0.75) /2;
    _textView.frame = frame;
    
    
    [_scrollView setContentSize:CGSizeMake(width(self.view), CGRectGetMaxY(_textView.frame) + kGeomBottomPadding)];
}




- (void)onCallButtonPressed {
    NSLog(@"call");
    NSString *phNo = @"+919876543210";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        NSLog(@"not available");
    }
}

- (void)onMailButtonPressed {
    NSLog(@"email");
    // Email Subject
    NSString *emailTitle = @"about Charter information";
    // Email Content
    NSString *messageBody = @"Hello";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"passagenautical@passagenautical.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}









@end
