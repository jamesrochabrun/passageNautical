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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *generalTermsButton;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    
    NSLog(@"internal code %@  == %@", self.charterService.productCode, self.charterFavorite.productCode);

    self.navigationController.navigationBar.hidden = NO;
    [self setButtonssAppereance];
    [self setTextViewsAppereance];
    [self setlabelsAppereance];
    [self addShadowToImageView];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *3)];
    
    NSLog(@"es %d", self.isItFavorite);
    
    
    if (self.charterFavorite.isFavorite) {
        [self displayCharterFavoriteObjectData];
        [self.loveButton setSelected:YES];
    } else {
        [self displayCharterDetailInformation];
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

- (void)displayCharterDetailInformation {
    
    self.title = self.charterService.name;
    //display the first image of the charter gallery
    NSDictionary *imagesDictionary = [self.charterService.images firstObject];
    NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [self.imageView setImageWithURL:[NSURL URLWithString:itemUrlWithNoSpaces]
                   placeholderImage:[UIImage imageNamed:@"yate"]];
    
    //display price
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", self.charterService.currency , self.charterService.advertisedPrice];
    
    //display infromation labels
    int hours = [self.charterService.durationMinutes intValue] /60;
    self.durationHoursLabel.text = [NSString stringWithFormat:@"%d H",hours];
    
    //display shortDescription
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:self.charterService.shortDescription];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [self.textView setText:stringWithNoHTML];
}

- (void)displayCharterFavoriteObjectData {
    
    self.title = self.charterFavorite.name;
    //display the first image of the charter gallery
    [self.imageView setImageWithURL:[NSURL URLWithString:self.charterFavorite.imageURL]
                   placeholderImage:[UIImage imageNamed:@"yate"]];
    //display price
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", self.charterFavorite.currency , self.charterFavorite.advertisedPrice];

    //display infromation labels
    int hours = [self.charterFavorite.durationMinutes intValue] /60;
    self.durationHoursLabel.text = [NSString stringWithFormat:@"%d H",hours];
    
    //display shortDescription
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:self.charterFavorite.shortCharterDescription];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [self.textView setText:stringWithNoHTML];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (self.charterFavorite != nil) {
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
    } else {
        DescriptionViewController *desVC = segue.destinationViewController;
        if ([segue.identifier isEqualToString:@"DescriptionSegue"]) {
            desVC.labelData = self.charterService.name;
            desVC.textFieldData = self.charterService.charterDescription;
        } else if ([segue.identifier isEqualToString:@"generalTerms"]) {
            desVC.labelData = @"General Terms";
            desVC.textFieldData = self.charterService.generalTerms;
        } else{
            MapViewController *mapViewController = segue.destinationViewController;
            mapViewController.charterService = self.charterService;
        }
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
    NSString *messageBody = [NSString stringWithFormat:@"I am interested in rent the %@", self.charterService.name];
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
    NSString *shareText = [NSString stringWithFormat:@"%@, %@", self.charterService.advertisedPrice , self.charterService.shortDescription];
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
    isFavorite = !isFavorite;
    
    if (isFavorite) {
        [sender setSelected:YES];
        [self saveInCoreData];
        NSLog(@"te guard0");
    } else {
        [sender setSelected:NO];

        [self deleteFromCoredata];
        NSLog(@"te borro");
    }
}

- (void)saveInCoreData {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    self.charterFavorite = [NSEntityDescription insertNewObjectForEntityForName:@"CharterFavorite" inManagedObjectContext:coreDataStack.managedObjectContext];
    self.charterFavorite.name = self.charterService.name;
    self.charterFavorite.currency = self.charterService.currency;
    self.charterFavorite.advertisedPrice = self.charterService.advertisedPrice;
    self.charterFavorite.charterDescription = self.charterService.charterDescription;
    self.charterFavorite.shortCharterDescription = self.charterService.shortDescription;
    self.charterFavorite.latitude = [NSString stringWithFormat:@"%@",self.charterService.latitude];
    self.charterFavorite.longitude = [NSString stringWithFormat:@"%@",self.charterService.longitude];
    self.charterFavorite.durationMinutes = self.charterService.durationMinutes;
    self.charterFavorite.generalTerms = self.charterService.generalTerms;
    self.charterFavorite.productCode = self.charterService.productCode;
    
    BOOL myBool = YES;
    self.charterFavorite.isFavorite = [NSNumber numberWithBool:myBool];
    self.charterFavorite.date = [[NSDate date] timeIntervalSince1970];
    
    NSDictionary *imagesDictionary = [self.charterService.images firstObject];
    NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    self.charterFavorite.imageURL = itemUrlWithNoSpaces;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.charterService.bookingFields];
    self.charterFavorite.bookingFields = data;
    
    [coreDataStack saveContext];
    
    UIAlertController *alertSaved = [UIAlertController alertControllerWithTitle:@"Added to favorites!" message:@"You can revisit this in your favorites section" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertSaved animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertSaved dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)deleteFromCoredata {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [[coreDataStack managedObjectContext] deleteObject:self.charterFavorite];
    [coreDataStack saveContext];
}















@end
