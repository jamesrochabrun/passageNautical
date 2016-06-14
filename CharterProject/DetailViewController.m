//
//  DetailViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 13-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"


@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad {
    self.title = self.charterService.name;
    [self displayCharterDetailInformation];
    [self setItemsAppereance];
}

- (void)setItemsAppereance {
    
    //scrollview
    [self.scrollView setScrollEnabled:YES];
    //
    self.videoButton.layer.borderColor = [UIColor colorWithRed:0.4549 green:1.0 blue:0.7608 alpha:1.0].CGColor;
    self.videoButton.layer.borderWidth = 2.0f;
    
    [self.textView setFont:[UIFont fontWithName:@"Gotham Narrow" size:15]];
    [self.textView setScrollEnabled:NO];
    [self.textView setUserInteractionEnabled:NO];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setText:self.charterService.charterDescription];
    [self.textView sizeToFit];

    

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
    self.priceLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:20];
}


@end
