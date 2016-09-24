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
#import "TopView.h"
#import "CommonUIConstants.h"

@interface DescriptionViewController ()
@property (nonatomic, strong) TopView *topView;
@property (nonatomic, strong) UILabel *charterLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    
    _topView = [TopView new];
    _topView.delegate = self;
    [self.view addSubview:_topView];
    
    _scrollView = [UIScrollView new];
    [_scrollView setScrollEnabled:YES];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _charterLabel = [UILabel new];
    _charterLabel.text = _labelDataText;
    [_charterLabel setFont:[UIFont regularFont:15]];
    _charterLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _charterLabel.numberOfLines = 0;
    _charterLabel.textAlignment = NSTextAlignmentCenter;
    [_charterLabel setTextColor:[UIColor customMainColor]];
    [_scrollView addSubview:_charterLabel];
    
    _textView = [UITextView new];
    _textView.scrollEnabled = NO;
    NSString *stringWithNoHTMLEntities = [NSString decodeHTMLEntities:self.textFieldData];
    NSString *stringWithNoHTML = [NSString convertHTMLInString:stringWithNoHTMLEntities];
    [_textView setText:stringWithNoHTML];
    _textView.font = [UIFont regularFont:14];
    _textView.textColor = [UIColor customTextColor];
    [_scrollView addSubview:_textView];
    
    
    
}


   // _textView.scrollEnabled = NO;

//    CGSize sizeThatShouldFitTheContent = [_textView sizeThatFits:_textView.bounds.size];
//    _heightTextView.constant = sizeThatShouldFitTheContent.height;
//    

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect frame = _topView.frame;
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.origin.y = CGRectGetMinY(self.view.frame);
    frame.size.width = width(self.view);
    frame.size.height = kGeomTopViewHeight;
    _topView.frame = frame;
    
    frame = _scrollView.frame;
    frame.origin.y = CGRectGetMaxY(_topView.frame);
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.size.height = height(self.view) ;
    frame.size.width = width( self.view);
    _scrollView.frame = frame;
    
    frame = _charterLabel.frame;
    frame.size.height = kGeomHeightTextField;
    frame.size.width = width(self.view) * 0.75;
    frame.origin.y = CGRectGetMinY(_scrollView.frame) - kGeomTopViewHeight + kGeomMarginMedium;
    frame.origin.x = (width(self.view) - frame.size.width) /2;
    _charterLabel.frame = frame;
    
    [self textViewDidChange:_textView];
    
    [_scrollView setContentSize:CGSizeMake(width(self.view), CGRectGetMaxY(_textView.frame) + kGeomBottomPadding)];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    CGFloat fixedWidth = width(self.view) * 0.8;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    newFrame.origin.x = (width(self.view) - fixedWidth) /2;
    newFrame.origin.y = CGRectGetMaxY(_charterLabel.frame) + kGeomMarginMedium;
    textView.frame = newFrame;
}

- (void)dismissVC {
    
    __weak DescriptionViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    });
}



//- (void)viewDidAppear:(BOOL)animated {
//    
//    [_scrollView setContentSize:CGSizeMake(width(self.view), CGRectGetMaxY(_textView.frame))];
//}






@end
