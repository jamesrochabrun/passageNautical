//
//  ZoomViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 9/27/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ZoomViewController.h"
#import "TopView.h"
#import "Common.h"
#import "CommonUIConstants.h"

@interface ZoomViewController ()
@property (nonatomic, strong) TopView *topView;

@end

@implementation ZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _topView = [TopView new];
    _topView.delegate = self;
    [self.view addSubview:_topView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    CGRect frame = _topView.frame;
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.origin.y = CGRectGetMinY(self.view.frame);
    frame.size.width = width(self.view);
    frame.size.height = kGeomTopViewHeight;
    _topView.frame = frame;
}



- (void)dismissVC {
    
    __weak ZoomViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    });
}





@end
