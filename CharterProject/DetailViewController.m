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
#import "CoreDataStack.h"
#import "CharterFavorite.h"

@interface DetailViewController ()<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;
@property (weak, nonatomic) IBOutlet UIButton *giftCardButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTextViewConstraint;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *mailButton;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
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
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *3)];
    [self displayCharterFavoriteObjectData];
    

    BOOL isFavorite = [self.charterFavorite.isFavorite boolValue];
    
    if (isFavorite) {
        [self.loveButton setSelected:YES];
    } else {
        [self.loveButton setSelected:NO];
    }


}


- (void)addShadowToImageView {
    self.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(0, 4);
    self.imageView.layer.shadowOpacity = 0.7;
    self.imageView.layer.shadowRadius = 10;
    self.imageView.clipsToBounds = NO;
}

- (void)setButtonssAppereance {

    [self.readMoreButton setTintColor:[UIColor customMainColor]];
    self.readMoreButton.titleLabel.font = [UIFont regularFont:15];
    self.videoButton.layer.borderColor = [UIColor customMainColor].CGColor;
    self.videoButton.layer.borderWidth = 2.0f;
    self.videoButton.titleLabel.font = [UIFont regularFont:17];
    self.giftCardButton.layer.borderColor = [UIColor customMainColor].CGColor;
    self.giftCardButton.layer.borderWidth = 2.0f;
    [self.giftCardButton setTintColor:[UIColor customMainColor]];
    self.giftCardButton.titleLabel.font = [UIFont regularFont:17];
    [self.phoneButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.phoneButton setTintColor:[UIColor whiteColor]];
    [self.mailButton setImage:[UIImage imageNamed:@"mail"] forState:UIControlStateNormal];
    [self.loveButton setImage:[UIImage imageNamed:@"love"] forState:UIControlStateNormal];
    [self.loveButton setImage:[UIImage imageNamed:@"fullLove"] forState:UIControlStateSelected];
    [self.loveButton setTintColor:[UIColor customMainColor]];
    [self.mailButton setTintColor:[UIColor whiteColor]];
    [self.mapButton setTintColor:[UIColor customMainColor]];
    self.mapButton.titleLabel.font = [UIFont regularFont:15];
    self.mapButton.layer.borderWidth = 2.0f;
    self.mapButton.layer.borderColor = [UIColor customMainColor].CGColor;
    [self.generalTermsButton setTintColor:[UIColor customMainColor]];
    self.generalTermsButton.titleLabel.font = [UIFont regularFont:14];
}


- (void)setTextViewsAppereance {
    [self.textView setFont:[UIFont regularFont:15]];
    [self.textView setScrollEnabled:NO];
    [self.textView setUserInteractionEnabled:NO];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    self.textView.textColor = [UIColor customTextColor];
       CGSize sizeThatShouldFitTheContent = [self.textView sizeThatFits:self.textView.frame.size];
    self.heightTextViewConstraint.constant = sizeThatShouldFitTheContent.height;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0.5363 green:0.5182 blue:0.3785 alpha:0.5];
    [self.textView addSubview:lineView];
}

- (void)setlabelsAppereance {
    self.numberOFpeopleLabel.font = [UIFont regularFont:18];
    self.numberOFpeopleLabel.textColor = [UIColor customTextColor];
    self.durationHoursLabel.font = [UIFont regularFont:18];
    self.durationHoursLabel.textColor = [UIColor customTextColor];
    self.extraLabel.font = [UIFont regularFont:18];
    self.extraLabel.textColor = [UIColor customTextColor];
    self.priceLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    self.priceLabel.font = [UIFont regularFont:20];
}

- (void)displayCharterFavoriteObjectData {
    
    self.title = self.charterFavorite.name;
    //display the first image of the charter gallery
    [self.imageView setImageWithURL:[NSURL URLWithString:self.charterFavorite.imageURL]
                   placeholderImage:[UIImage imageNamed:@"yate"]];
    //display price
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", self.charterFavorite.currency , self.charterFavorite.advertisedPrice];

    //display information labels
    int hours = [self.charterFavorite.durationMinutes intValue] /60;
    self.durationHoursLabel.text = [NSString stringWithFormat:@"%d H",hours];
    
    //display shortDescription
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:self.charterFavorite.shortCharterDescription];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [self.textView setText:stringWithNoHTML];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        DescriptionViewController *desVC = segue.destinationViewController;
        if ([segue.identifier isEqualToString:@"DescriptionSegue"]) {
            desVC.labelData = self.charterFavorite.name;
            desVC.textFieldData = self.charterFavorite.charterDescription;
        } else if ([segue.identifier isEqualToString:@"generalTerms"]) {
            desVC.labelData = @"General Terms";
            desVC.textFieldData = self.charterFavorite.generalTerms;
        } else{
            MapViewController *mapViewController = segue.destinationViewController;
            mapViewController.charterFavorite = self.charterFavorite;
        }
    
}

- (IBAction)callPassageNautical:(UIButton *)sender {
    NSString *phNo = @"+919876543210";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        NSLog(@"not available");
    }
}

- (IBAction)mailPassageNautical:(UIButton *)sender {
    // Email Subject
    NSString *emailTitle = @"about Charter information";
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"I am interested in rent the %@", self.charterFavorite.name];
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



- (IBAction)onShareButtonPressed:(UIButton *)sender {
    NSString *shareText = [NSString stringWithFormat:@"%@, %@", self.charterFavorite.advertisedPrice , self.charterFavorite.shortCharterDescription];
    NSURL *shareLink = [[NSURL alloc] initWithString:@"www.passagenautical.com"];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[shareText,shareLink]
                                      applicationActivities:nil];
    
    [activityViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [activityViewController setExcludedActivityTypes:@[UIActivityTypePostToWeibo,
                                                       UIActivityTypeCopyToPasteboard,
                                                       UIActivityTypeMessage]];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self presentViewController:activityViewController animated:YES completion:nil];
    });
}


- (IBAction)addToFavorites:(UIButton *)sender {

    BOOL isFavorite = [self.charterFavorite.isFavorite boolValue];
    if (!isFavorite) {
        [sender setSelected:YES];
        [self changingIsFavoriteToTrue];
    } else {
        [sender setSelected:NO];
        [self changingIsFavoriteToFalse];
    }
}

- (void)changingIsFavoriteToTrue {
    
    BOOL myBool = YES;
    self.charterFavorite.isFavorite = [NSNumber numberWithBool:myBool];
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
    
    UIAlertController *alertSaved = [UIAlertController alertControllerWithTitle:@"Added to favorites!" message:@"You can revisit this in your favorites section" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertSaved animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertSaved dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)changingIsFavoriteToFalse {
    BOOL myBool = NO;
    self.charterFavorite.isFavorite = [NSNumber numberWithBool:myBool];
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
}













@end
