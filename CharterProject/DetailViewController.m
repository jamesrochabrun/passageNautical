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
#import "BookingViewController.h"
#import "ListCVFL.h"
#import "UICollectionView+Additions.h"
#import "CharterCollectionViewCell.h"
#import "InfoView.h"
#import "PriceOptionObject.h"


@interface DetailViewController ()<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *videoButton;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *readMoreButton;
@property (nonatomic, strong) UIButton *giftCardButton;
@property (nonatomic, strong) UIButton *mapButton;
@property (nonatomic, strong) UIButton *generalTermsButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *listsLayout;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *bookButton;
@property (nonatomic, strong) InfoView *infoView;

@end

static NSString * const FilterCelIdentifier = @"FilterCellIdentifier";
static NSString *const itemURL =  @"itemUrl";

@implementation DetailViewController


- (void)viewDidLoad {
    
//    NSLog(@"the price options are %lu", (unsigned long)_charterService.priceOptions.count);
//    for (PriceOptionObject *pO in _charterService.priceOptions) {
//        NSLog(@"the po label is %@", pO.priceOptionLabel);
//    }
//    
    self.title = self.charterService.name;
    
    self.navigationController.navigationBar.hidden = NO;
    _scrollView = [UIScrollView new];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];

    _listsLayout = [[ListCVFL alloc] init];
    [_listsLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _listsLayout.minimumInteritemSpacing = 0;
    _listsLayout.minimumLineSpacing = 0;
    
    _collectionView = [UICollectionView collectionViewWithLayout:_listsLayout inView:self.view delegate:self];
    [_collectionView registerClass:[CharterCollectionViewCell class] forCellWithReuseIdentifier:FilterCelIdentifier];
    _collectionView.pagingEnabled = YES;
    _collectionView.layer.shadowColor = [UIColor blackColor].CGColor;
    _collectionView.layer.shadowOffset = CGSizeMake(0, 4);
    _collectionView.layer.shadowOpacity = 0.7;
    _collectionView.layer.shadowRadius = 10;
    _collectionView.clipsToBounds = NO;
    [_scrollView addSubview:_collectionView];
    
    _infoView = [InfoView new];
    _infoView.charter = self.charterService;
    [_scrollView addSubview:_infoView];
    
    _textView = [UITextView new];
    _textView.scrollEnabled = NO;
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:_charterService.shortDescription];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [_textView setText:stringWithNoHTML];
    _textView.font = [UIFont regularFont:14];
    _textView.textColor = [UIColor customTextColor];
    //_textView.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_textView];
    
    _readMoreButton = [UIButton new];
    [_readMoreButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    _readMoreButton.titleLabel.font = [UIFont regularFont:15];
    [_readMoreButton addTarget:self action:@selector(performReadMoreSegue:) forControlEvents:UIControlEventTouchUpInside];
    [_readMoreButton setTitle:@"Read More" forState:UIControlStateNormal];
    [_scrollView addSubview:_readMoreButton];
    
    _mapButton = [UIButton new];
    [_mapButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    _mapButton.titleLabel.font = [UIFont regularFont:15];
    _mapButton.layer.borderWidth = 2.0f;
    _mapButton.layer.borderColor = [UIColor customMainColor].CGColor;
    [_mapButton setTitle:@"Show Departure Point" forState:UIControlStateNormal];
    [_mapButton addTarget:self action:@selector(performMapSegue:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_mapButton];
    
    _shareButton = [UIButton new];
    [_shareButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    _shareButton.titleLabel.font = [UIFont regularFont:15];
    _shareButton.layer.borderWidth = 2.0f;
    _shareButton.layer.borderColor = [UIColor customMainColor].CGColor;
    [_shareButton setTitle:@"Share With a Friend" forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(onShareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_shareButton];
    
    _generalTermsButton = [UIButton new];
    [_generalTermsButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    _generalTermsButton.titleLabel.font = [UIFont regularFont:15];
    [_generalTermsButton addTarget:self action:@selector(performGeneralTermsSegue:) forControlEvents:UIControlEventTouchUpInside];
    [_generalTermsButton setTitle:@"General Terms" forState:UIControlStateNormal];
    [_scrollView addSubview:_generalTermsButton];
    
    _bookButton = [UIButton new];
    [_bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _bookButton.titleLabel.font = [UIFont regularFont:17];
    [_bookButton addTarget:self action:@selector(performBookSegue:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([_charterService.bookingMode isEqualToString:kKeyBookingModeNoDate]) {
        [_bookButton setTitle:@"Book Now" forState:UIControlStateNormal];
    } else {
        [_bookButton setTitle:@"Check Availability" forState:UIControlStateNormal];
    }
    
    _bookButton.backgroundColor = [UIColor customMainColor];
    [self.view addSubview:_bookButton];
    
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect frame = _bookButton.frame;
    frame.size.height = kGeomHeightBigbutton;
    frame.size.width = width(self.view);
    frame.origin.x = 0;
    frame.origin.y = height(self.view) - kGeomHeightBigbutton;
    _bookButton.frame = frame;
    
    frame = _scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = width(self.view);
    frame.size.height = height(self.view) - kGeomHeightBigbutton;
    _scrollView.frame = frame;
    
    frame = _collectionView.frame;
    frame.origin.x = originX(_scrollView);
    frame.origin.y = originY(_scrollView);
    frame.size.width = width(self.view);
    frame.size.height = 220;
    _collectionView.frame = frame;
    
    frame = _infoView.frame;
    frame.origin.x = originX(_scrollView);
    frame.origin.y = CGRectGetMaxY(_collectionView.frame) + kGeomMarginMedium;
    frame.size.width = width(_scrollView);
    frame.size.height = 90;
    _infoView.frame = frame;
    
    [self textViewDidChange:_textView];
    
    frame = _readMoreButton.frame;
    frame.size.height = kGeomHeightTextField;
    frame.size.width = kGeomWidthBigButton;
    frame.origin.x = (width(_scrollView) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_textView.frame) + kGeomMarginSmall;
    _readMoreButton.frame = frame;
    
    frame = _mapButton.frame;
    frame.size.height = kGeomHeightBigbutton;
    frame.size.width = kGeomWidthBigButton;
    frame.origin.x = (width(_scrollView) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_readMoreButton.frame) + kGeomMarginMedium;
    _mapButton.frame = frame;
    
    frame = _shareButton.frame;
    frame.size.height = kGeomHeightBigbutton;
    frame.size.width = kGeomWidthBigButton;
    frame.origin.x = (width(_scrollView) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_mapButton.frame) + kGeomMarginMedium;
    _shareButton.frame = frame;
    
    frame = _generalTermsButton.frame;
    frame.size.height = kGeomHeightTextField;
    frame.size.width = kGeomWidthBigButton;
    frame.origin.x = (width(_scrollView) - frame.size.width) /2;
    frame.origin.y = CGRectGetMaxY(_shareButton.frame) + kGeomMarginMedium;
    _generalTermsButton.frame = frame;
    
    _scrollView.contentSize = CGSizeMake(width(self.view), CGRectGetMaxY(_generalTermsButton.frame) + kGeomBottomPadding);

    
}


- (void)textViewDidChange:(UITextView *)textView {
    
    CGFloat fixedWidth = width(self.view) * 0.8;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    newFrame.origin.x = (width(self.view) - fixedWidth) /2;
    newFrame.origin.y = CGRectGetMaxY(_infoView.frame) + kGeomMarginSmall;
    textView.frame = newFrame;
}

- (void)performReadMoreSegue:(id)sender {
    [self performSegueWithIdentifier:@"readMore" sender:sender];
}

- (void)performGeneralTermsSegue:(id)sender {
    [self performSegueWithIdentifier:@"generalTerms" sender:sender];
}

- (void)performMapSegue:(id)sender {
    [self performSegueWithIdentifier:@"map" sender:sender];
}

- (void)performBookSegue:(id)sender {
    [self performSegueWithIdentifier:@"book" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        DescriptionViewController *desVC = segue.destinationViewController;
        if ([segue.identifier isEqualToString:@"readMore"]) {
            desVC.labelDataText = _charterService.name;
            desVC.textFieldData = _charterService.charterDescription;
        } else if ([segue.identifier isEqualToString:@"generalTerms"]) {
            desVC.labelDataText = @"General Terms";
            desVC.textFieldData = _charterService.generalTerms;
        } else if ([segue.identifier isEqualToString:@"map"]){
            MapViewController *mapViewController = segue.destinationViewController;
            mapViewController.charterService = _charterService;
        } else if ([segue.identifier isEqualToString:@"book"]) {
            BookingViewController *bVC = segue.destinationViewController;
            bVC.charterService = _charterService;
        }
}

- (void)callNumber {
    
    NSLog(@"call");

    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",kcontactNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        NSLog(@"not available");
    }
}

- (void)sendEmail {
    NSLog(@"email");
    
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


- (void)onShareButtonPressed {
    
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


#pragma collectionView Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _charterService.images.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kGeomMinSpace;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(width(_collectionView) , height(_collectionView));
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CharterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FilterCelIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    NSDictionary *imagesDictionary = [_charterService.images objectAtIndex:indexPath.row];
    NSString *urlStr = [CharterService urlStringWithNoSpaces:imagesDictionary];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ %@", _charterService.currency , _charterService.advertisedPrice];
    [cell.doubleTapImage setImageWithURL:[NSURL URLWithString:urlStr]
                        placeholderImage:[UIImage imageNamed:@"yate"]];
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,0,0,0);
}









@end
