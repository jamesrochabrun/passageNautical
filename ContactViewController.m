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
#import "Common.h"
#import "CommonUIConstants.h"
#import "CustomToolBar.h"
#import <MessageUI/MessageUI.h>



@interface ContactViewController()<UIScrollViewDelegate>

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
    
    CustomToolBar *toolBar = [CustomToolBar new];
    [toolBar.contact setTintColor:[UIColor customMainColor]];
    toolBar.del = self;
    [self.view addSubview:toolBar];
}

- (void)goToHome {
    [self performSegueWithIdentifier:@"home" sender:self];

}
- (void)goToFavorites {
    [self performSegueWithIdentifier:@"favorites" sender:self];
}

- (void)goToContact {
    NSLog(@"I am already in contact");
}


- (void)displayContentInViewController {
    
    _statusBarViewBackground = [UIView new];
    _statusBarViewBackground.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_statusBarViewBackground];

    _scrollView = [UIScrollView new];
    _scrollView.delegate = self;
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
    _contactLabel.alpha = 0;
    [_scrollView addSubview:_contactLabel];
    
    _callButton = [UIButton new];
    [_callButton setTitle:@"Call" forState:UIControlStateNormal];
    [_callButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [_callButton addTarget:self action:@selector(onCallButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _callButton.layer.borderColor = [UIColor customMainColor].CGColor;
    _callButton.layer.borderWidth = 2.0f;
    [_callButton.titleLabel setFont:[UIFont regularFont:22]];
    _callButton.alpha = 0;
    [_scrollView addSubview:_callButton];
    
    _mailButton = [UIButton new];
    [_mailButton setTitle:@"Send us Email" forState:UIControlStateNormal];
    [_mailButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [_mailButton addTarget:self action:@selector(onMailButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _mailButton.layer.borderColor = [UIColor customMainColor].CGColor;
    _mailButton.layer.borderWidth = 2.0f;
    [_mailButton.titleLabel setFont:[UIFont regularFont:22]];
    _mailButton.alpha = 0;
    [_scrollView addSubview:_mailButton];
    
    _logoView = [UIImageView new];
    _logoView.contentMode = UIViewContentModeScaleToFill;
    _logoView.image = [UIImage imageNamed:@"logo"];
    _logoView.contentMode = UIViewContentModeScaleAspectFit;
    _logoView.alpha = 0;
    [_scrollView addSubview:_logoView];
    
    _textView = [UITextView new];
    _textView.showsVerticalScrollIndicator = NO;
    _textView.userInteractionEnabled = NO;
    _textView.font = [UIFont regularFont:15];
    _textView.textColor = [UIColor customTextColor];
    _textView.scrollEnabled = NO;
    _textView.text = kcompanyDescription;
    _textView.alpha = 0;
    [_scrollView addSubview:_textView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _logoView.alpha =
    _textView.alpha =
    _contactLabel.alpha =
    _mailButton.alpha =
    _callButton.alpha = 0;
    [UIView animateWithDuration:.7 animations:^{

        _contactLabel.alpha =
        _mailButton.alpha =
        _callButton.alpha = 1;
    }];
    
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
    frame.size.height = height(_scrollView) * 0.9;
    _imageView.frame = frame;
    
    [_contactLabel sizeToFit];
    frame = _contactLabel.frame;
    frame.origin.x = (width(self.view) - width(_contactLabel)) /2;
    frame.origin.y = CGRectGetMaxY(_imageView.frame) - kGeomHeightBigbutton *4 - kGeomMarginMedium;
    _contactLabel.frame = frame;
    
    frame = _callButton.frame;
    frame.size.width = kGeomWidthBigButton;
    frame.size.height = kGeomHeightBigbutton;
    frame.origin.x = (width(_imageView) - kGeomWidthBigButton) /2;
    frame.origin.y = CGRectGetMaxY(_imageView.frame) - kGeomHeightBigbutton *3 - kGeomMarginMedium;
    _callButton.frame = frame;
    
    frame = _mailButton.frame;
    frame.size.width = kGeomWidthBigButton;
    frame.size.height = kGeomHeightBigbutton;
    frame.origin.x = (width(_imageView) - kGeomWidthBigButton) /2;
    frame.origin.y = CGRectGetMaxY(_imageView.frame) - kGeomHeightBigbutton *2;
    _mailButton.frame = frame;
    
    frame = _logoView.frame;
    frame.size.width = 220;
    frame.size.height = 70;
    frame.origin.x = (width(_scrollView) - 220) /2;
    frame.origin.y = CGRectGetMaxY(_imageView.frame) + kGeomMarginMedium;
    _logoView.frame = frame;
    
    frame = _textView.frame;
    frame.size.width = width(self.view) * 0.75;
    frame.size.height = [_textView sizeThatFits:CGSizeMake(frame.size.width, FLT_MAX)].height;
    frame.origin.y = CGRectGetMaxY(_logoView.frame) + kGeomMarginMedium;
    frame.origin.x = (width(self.view) - width(self.view) *0.75) /2;
    _textView.frame = frame;
    
    [_scrollView setContentSize:CGSizeMake(width(self.view), CGRectGetMaxY(_textView.frame) + kGeomBottomPadding)];
}

- (void)onCallButtonPressed {
    NSLog(@"call");
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:kKeyPhonePrompt,kcontactNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        NSLog(@"not available");
    }
}

- (void)onMailButtonPressed {
    
    // Email Subject
    NSString *emailTitle = kemailSubject;
    // Email Content
    NSString *messageBody = @"Hello";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:kcontactEmail];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    if (mc) {
        __weak ContactViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:mc animated:YES completion:NULL];
        });
    }
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

#pragma scroll delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [UIView animateWithDuration:1 animations:^{
        _logoView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            _textView.alpha = 1;
        }];
    }];
}







@end
