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



@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    self.title = self.charterService.name;
    [self displayCharterDetailInformation];
    [self setItemsAppereance];
}

- (void)setItemsAppereance {
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *2)];
    
    
    self.videoButton.layer.borderColor = [UIColor customMainColor].CGColor;
    self.videoButton.layer.borderWidth = 2.0f;
    [self.textView setFont:[UIFont regularFont:15]];
    [self.textView setScrollEnabled:NO];
    [self.textView setUserInteractionEnabled:NO];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    
    NSString *stringWithNoHTMLEntities = [self decodeHTMLEntities:self.charterService.charterDescription];
    NSString *stringWithNoHTML = [self convertHTMLInString:stringWithNoHTMLEntities];
    [self.textView setText:stringWithNoHTML];
    
    CGSize sizeThatShouldFitTheContent = [self.textView sizeThatFits:self.textView.frame.size];
    self.heightConstraint.constant = sizeThatShouldFitTheContent.height;

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







#pragma Methods for Decoding HTML for charter description

- (NSString*)decodeHTMLEntities:(NSString*)string {
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    return string;
    
}

-(NSString *)convertHTMLInString:(NSString *)html {
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}







@end
