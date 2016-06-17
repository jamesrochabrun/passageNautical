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



@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;
@property (weak, nonatomic) IBOutlet UIButton *giftCardButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTextViewConstraint;


@end

@implementation DetailViewController


- (void)viewDidLoad {
    self.title = self.charterService.name;
    [self displayCharterDetailInformation];
    [self setItemsAppereance];
}

- (void)setItemsAppereance {
    
    //scrollview
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *3)];

    
    //textView
    [self.textView setFont:[UIFont regularFont:15]];
    [self.textView setScrollEnabled:NO];
    [self.textView setUserInteractionEnabled:NO];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    self.textView.textColor = [UIColor customTextColor];
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:self.charterService.shortDescription];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [self.textView setText:stringWithNoHTML];
    CGSize sizeThatShouldFitTheContent = [self.textView sizeThatFits:self.textView.frame.size];
    self.heightTextViewConstraint.constant = sizeThatShouldFitTheContent.height;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0.5363 green:0.5182 blue:0.3785 alpha:0.5];
    [self.textView addSubview:lineView];
    
    //buttons
    [self.readMoreButton setTintColor:[UIColor customMainColor]];
    self.readMoreButton.titleLabel.font = [UIFont regularFont:15];
    self.videoButton.layer.borderColor = [UIColor customMainColor].CGColor;
    self.videoButton.layer.borderWidth = 2.0f;
    self.videoButton.titleLabel.font = [UIFont regularFont:17];
    self.giftCardButton.layer.borderColor = [UIColor customMainColor].CGColor;
    self.giftCardButton.layer.borderWidth = 2.0f;
    [self.giftCardButton setTintColor:[UIColor customMainColor]];
    self.giftCardButton.titleLabel.font = [UIFont regularFont:17];


}

- (void)displayCharterDetailInformation {
    
    //display the first image of the charter gallery
    NSDictionary *imagesDictionary = [self.charterService.images firstObject];
    NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [self.imageView setImageWithURL:[NSURL URLWithString:itemUrlWithNoSpaces]
                   placeholderImage:[UIImage imageNamed:@"yate"]];
    
    //display price
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", self.charterService.currency , self.charterService.advertisedPrice];
    self.priceLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    self.priceLabel.font = [UIFont regularFont:20];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DescriptionViewController *desVC = segue.destinationViewController;
    desVC.charterService = self.charterService;
}







#pragma Methods for Decoding HTML for charter description











@end
