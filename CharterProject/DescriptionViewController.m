//
//  DescriptionViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 16-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "DescriptionViewController.h"
#import "CharterService.h"
#import "NSString+DecodeHTML.h"
#import "UIFont+CustomFont.h"
#import "UIColor+MainColor.h"

@interface DescriptionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *charterLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *textViewTerms;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTextViewTerms;





@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    
    [self displayContentInViewController];
    [self.scrollView setScrollEnabled:YES];
//    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height )];
}

- (void)displayContentInViewController {
 

    self.charterLabel.text = self.charterService.name;
    self.charterLabel.font = [UIFont mediumFont:19];
    self.charterLabel.textColor = [UIColor customMainColor];
    
    self.textView.scrollEnabled = NO;
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:self.charterService.charterDescription];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [self.textView setText:stringWithNoHTML];
    self.textView.font = [UIFont regularFont:14];
    self.textView.textColor = [UIColor customTextColor];
    CGSize sizeThatShouldFitTheContent = [self.textView sizeThatFits:self.textView.frame.size];
    self.heightTextView.constant = sizeThatShouldFitTheContent.height;
    
    self.textViewTerms.scrollEnabled = NO;
    [self.textViewTerms setText:self.charterService.generalTerms];
    self.textViewTerms.font = [UIFont regularFont:14];
    self.textViewTerms.textColor = [UIColor customTextColor];
    CGSize sizeThatShouldFitTheContentTerms = [self.textViewTerms sizeThatFits:self.textViewTerms.frame.size];
    self.heightTextViewTerms.constant = sizeThatShouldFitTheContentTerms.height;
    
}

- (IBAction)dismissViewControllerButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}








@end
