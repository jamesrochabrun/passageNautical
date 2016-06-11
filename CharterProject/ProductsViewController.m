//
//  ProductsViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ProductsViewController.h"

@interface ProductsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"count = %lu", self.array.count);
}



@end
