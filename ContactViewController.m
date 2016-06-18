//
//  ContatViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 18-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController()

@end

@implementation ContactViewController


- (void)viewDidLoad {
    
}



- (void)displayContentInViewController {
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *2)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width , self.view.frame.size.height*2)];
    [scrollView addSubview:view];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"debbie"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [view addSubview:imageView];

}


@end
