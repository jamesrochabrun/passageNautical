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
    
    _scrollView.showsVerticalScrollIndicator = NO;

    _charterLabel.text = self.labelData;
    _charterLabel.font = [UIFont mediumFont:19];
    _charterLabel.textColor = [UIColor customMainColor];
    
    _textView.scrollEnabled = NO;
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:self.textFieldData];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [_textView setText:stringWithNoHTML];
    _textView.font = [UIFont regularFont:14];
    _textView.textColor = [UIColor customTextColor];
    CGSize sizeThatShouldFitTheContent = [_textView sizeThatFits:_textView.bounds.size];
    _heightTextView.constant = sizeThatShouldFitTheContent.height;
    
}

- (IBAction)dismissViewControllerButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [_scrollView setContentSize:CGSizeMake(width(self.view), CGRectGetMaxY(_textView.frame))];
}






@end
