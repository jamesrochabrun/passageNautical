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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTextView;



@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    
    [self displayContentInViewController];
    [self.scrollView setScrollEnabled:YES];
}

- (void)displayContentInViewController {
 

    self.charterLabel.text = self.labelData;
    self.charterLabel.font = [UIFont mediumFont:19];
    self.charterLabel.textColor = [UIColor customMainColor];
    
    self.textView.scrollEnabled = NO;
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:self.textFieldData];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [self.textView setText:stringWithNoHTML];
    self.textView.font = [UIFont regularFont:14];
    self.textView.textColor = [UIColor customTextColor];
    CGSize sizeThatShouldFitTheContent = [self.textView sizeThatFits:self.textView.frame.size];
    self.heightTextView.constant = sizeThatShouldFitTheContent.height;

    
}

- (IBAction)dismissViewControllerButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}








@end
