//
//  DetailViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 13-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"
#import "CharterService.h"
#import "DescriptionViewController.h"
#import "NSString+DecodeHTML.h"
#import <MessageUI/MessageUI.h>
#import "MapViewController.h"
#import "DoubleTapImage.h"
#import "CommonUIConstants.h"

@interface DetailViewController ()<MFMailComposeViewControllerDelegate, DoubleTapImageDelegate>

@property (weak, nonatomic) IBOutlet DoubleTapImage *doubleTapImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;
@property (weak, nonatomic) IBOutlet UIButton *giftCardButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTextViewConstraint;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *mailButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOFpeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *extraLabel;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *generalTermsButton;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    
    self.navigationController.navigationBar.hidden = NO;
    [self setButtonssAppereance];
    [self setTextViewsAppereance];
    [self setlabelsAppereance];
    [self addShadowToImageView];
    [_scrollView setContentSize:CGSizeMake(width(self.view), height(self.view) *3)];
    [self displayCharterServiceData];

    _doubleTapImageView.delegate = self;
    

    NSLog(@"the latitude is %@ and longitude is %@", _charterService.latitude, _charterService.longitude);
}

- (void)addShadowToImageView {
    
    _doubleTapImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    _doubleTapImageView.layer.shadowOffset = CGSizeMake(0, 4);
    _doubleTapImageView.layer.shadowOpacity = 0.7;
    _doubleTapImageView.layer.shadowRadius = 10;
    _doubleTapImageView.clipsToBounds = NO;
}

- (void)setButtonssAppereance {

    [_readMoreButton setTintColor:[UIColor customMainColor]];
    _readMoreButton.titleLabel.font = [UIFont regularFont:15];
    _videoButton.layer.borderColor = [UIColor customMainColor].CGColor;
    _videoButton.layer.borderWidth = 2.0f;
    _videoButton.titleLabel.font = [UIFont regularFont:17];
    _giftCardButton.layer.borderColor = [UIColor customMainColor].CGColor;
    _giftCardButton.layer.borderWidth = 2.0f;
    [_giftCardButton setTintColor:[UIColor customMainColor]];
    _giftCardButton.titleLabel.font = [UIFont regularFont:17];
    [_phoneButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [_phoneButton setTintColor:[UIColor whiteColor]];
    [_mailButton setImage:[UIImage imageNamed:@"mail"] forState:UIControlStateNormal];
    [_mailButton setTintColor:[UIColor whiteColor]];
    [_mapButton setTintColor:[UIColor customMainColor]];
    _mapButton.titleLabel.font = [UIFont regularFont:15];
    _mapButton.layer.borderWidth = 2.0f;
    _mapButton.layer.borderColor = [UIColor customMainColor].CGColor;
    [_generalTermsButton setTintColor:[UIColor customMainColor]];
    _generalTermsButton.titleLabel.font = [UIFont regularFont:14];
}


- (void)setTextViewsAppereance {
    
    [_textView setFont:[UIFont regularFont:15]];
    [_textView setScrollEnabled:NO];
    [_textView setUserInteractionEnabled:NO];
    [_textView setBackgroundColor:[UIColor clearColor]];
    _textView.textColor = [UIColor customTextColor];
    CGSize sizeThatShouldFitTheContent = [_textView sizeThatFits:_textView.frame.size];
    _heightTextViewConstraint.constant = sizeThatShouldFitTheContent.height;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.view), 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0.5363 green:0.5182 blue:0.3785 alpha:0.5];
    [_textView addSubview:lineView];
}

- (void)setlabelsAppereance {
    
    _numberOFpeopleLabel.font = [UIFont regularFont:18];
    _numberOFpeopleLabel.textColor = [UIColor customTextColor];
    _durationHoursLabel.font = [UIFont regularFont:18];
    _durationHoursLabel.textColor = [UIColor customTextColor];
    _extraLabel.font = [UIFont regularFont:18];
    _extraLabel.textColor = [UIColor customTextColor];
    _priceLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    _priceLabel.font = [UIFont regularFont:20];
}

- (void)displayCharterServiceData {
    
    self.title = self.charterService.name;
    //display the first image of the charter gallery
    [_doubleTapImageView setImageWithURL:[NSURL URLWithString:_charterService.imageURL]
                   placeholderImage:[UIImage imageNamed:@"yate"]];
    //display price
    _priceLabel.text = [NSString stringWithFormat:@"%@ %@", _charterService.currency , _charterService.advertisedPrice];

    //display information labels
    int hours = [_charterService.durationMinutes intValue] /60;
    _durationHoursLabel.text = [NSString stringWithFormat:@"%d H",hours];
    
    //display shortDescription
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:_charterService.shortDescription];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [_textView setText:stringWithNoHTML];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        DescriptionViewController *desVC = segue.destinationViewController;
        if ([segue.identifier isEqualToString:@"DescriptionSegue"]) {
            desVC.labelData = _charterService.name;
            desVC.textFieldData = _charterService.charterDescription;
        } else if ([segue.identifier isEqualToString:@"generalTerms"]) {
            desVC.labelData = @"General Terms";
            desVC.textFieldData = _charterService.generalTerms;
        } else{
            MapViewController *mapViewController = segue.destinationViewController;
            mapViewController.charterService = _charterService;
        }
}

- (IBAction)callPassageNautical:(UIButton *)sender {
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",kcontactNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        NSLog(@"not available");
    }
}

- (IBAction)mailPassageNautical:(UIButton *)sender {
    // Email Subject
    NSString *emailTitle = kemailSubject;
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"I am interested in rent the %@", self.charterService.name];
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:kcontactEmail];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    if (mc) {
        __weak DetailViewController *weakSelf = self;
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
    __weak DetailViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:NULL];
    });
}



- (IBAction)onShareButtonPressed:(UIButton *)sender {
    
    NSString *shareText = [NSString stringWithFormat:@"%@, %@", self.charterService.advertisedPrice , self.charterService.shortDescription];
    NSURL *shareLink = [[NSURL alloc] initWithString:@"www.passagenautical.com"];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[shareText,shareLink]
                                      applicationActivities:nil];
    
    [activityViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [activityViewController setExcludedActivityTypes:@[UIActivityTypePostToWeibo,
                                                       UIActivityTypeCopyToPasteboard,
                                                       UIActivityTypeMessage]];
    
    __weak DetailViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [weakSelf presentViewController:activityViewController animated:YES completion:nil];
    });
}

- (void)didIamgeDoubleTapped {
    NSLog(@"hehh");
}














@end
