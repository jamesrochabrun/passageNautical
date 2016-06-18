//
//  ContatViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 18-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ContactViewController.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"

@interface ContactViewController()

@end

@implementation ContactViewController


- (void)viewDidLoad {
    [self displayContentInViewController];
    
}



- (void)displayContentInViewController {
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *2)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height*2)];
    [scrollView addSubview:view];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height/2)];
    imageView.image = [UIImage imageNamed:@"debbie"];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    [view addSubview:imageView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(20,20 , 45, 45)];
    backButton.backgroundColor = [UIColor redColor];
    [backButton addTarget:self action:@selector(onBackButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:backButton];
    
    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 21)];
    [contactLabel setCenter:(CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/1.6))];
    contactLabel.textAlignment = NSTextAlignmentCenter;
    contactLabel.font = [UIFont regularFont:28];
    contactLabel.textColor = [UIColor whiteColor];
    contactLabel.text = @"Contact";
    [imageView addSubview:contactLabel];
    
    UIButton *callButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 210, 40)];
    [callButton setTitle:@"Call" forState:UIControlStateNormal];
    
    


}

- (void)onBackButtonPressed {
    NSLog(@"hello");
}


@end
