//
//  FavoritesViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 20-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "FavoritesViewController.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"
#import "DetailViewController.h"
#import "Common.h"
#import "CommonUIConstants.h"
#import "CharterAPI.h"

@interface FavoritesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *wishLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *middleLabel;
@property (nonatomic, strong) UIButton *keepLookingButton;
@property (nonatomic, strong) UIImageView *shadow;
@property (nonatomic, strong) UIView *statusBarViewBackground;


@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    
    _statusBarViewBackground = [UIView new];
    _statusBarViewBackground.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_statusBarViewBackground];

    CustomToolBar *toolBar = [CustomToolBar new];
    [toolBar.favorites setTintColor:[UIColor customMainColor]];
    toolBar.del = self;
    [self.view addSubview:toolBar];
    
    [self setImageIfNotfavorites];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)setImageIfNotfavorites  {
    
    self.tableView.hidden = YES;
    
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"sanfrancisco"];
    _shadow = [UIImageView new];
    _shadow.image = [UIImage imageNamed:@"shadowA"];
    
    _wishLabel = [UILabel new];
    _wishLabel.textColor = [UIColor whiteColor];
    _wishLabel.font = [UIFont regularFont:24];
    _wishLabel.text = @"Coming soon";
    
    _textView = [UITextView new];
    _textView.userInteractionEnabled = NO;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.text = @"here we can add other feature";
    _textView.textColor = [UIColor whiteColor];
    _textView.font = [UIFont regularFont:14];
    
    _middleLabel = [UILabel new];
    _middleLabel.textAlignment = NSTextAlignmentNatural;
    _middleLabel.text = @"Comming soon";
    _middleLabel.textColor = [UIColor whiteColor];
    _middleLabel.font = [UIFont regularFont:20];
    _middleLabel.numberOfLines = 0;
    
    _keepLookingButton = [UIButton new];
    _keepLookingButton.layer.borderColor = [UIColor customMainColor].CGColor;
    _keepLookingButton.layer.borderWidth = 2.0f;
    [_keepLookingButton setTitle:@"Keep Looking" forState:UIControlStateNormal];
    [_keepLookingButton setTitleColor:[UIColor customMainColor] forState:UIControlStateNormal];
    [_keepLookingButton addTarget:self action:@selector(onKeepLookingButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_keepLookingButton.titleLabel setFont:[UIFont regularFont:22]];
    
    [self.view addSubview:_imageView];
    [self.view addSubview:_shadow];
    [self.view addSubview:_wishLabel];
    [self.view addSubview:_textView];
    [self.view addSubview:_middleLabel];
    [self.view addSubview:_keepLookingButton];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    CGRect frame = _statusBarViewBackground.frame;
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.origin.y = CGRectGetMinY(self.view.frame);
    frame.size.width = width(self.view);
    frame.size.height = kGeomHeightStatusBar;
    _statusBarViewBackground.frame = frame;
    
    frame = _imageView.frame;
    frame.origin.x = CGRectGetMinX(self.view.frame);
    frame.origin.y = kGeomHeightStatusBar;
    frame.size.height = height(self.view) - kGeomHeightToolBar;
    frame.size.width = width(self.view);
    _imageView.frame = frame;
    _shadow.frame = frame;
    
    [_wishLabel sizeToFit];
    frame = _wishLabel.frame;
    frame.origin.x = kGeomMarginBig;
    frame.origin.y = CGRectGetMinY(_imageView.frame) + kGeomMarginBig;
    _wishLabel.frame = frame;
    
    frame = _keepLookingButton.frame;
    frame.size.height = kGeomHeightBigbutton;
    frame.size.width = kGeomWidthBigButton;
    frame.origin.x = (width(self.view) - kGeomWidthBigButton) /2;
    frame.origin.y = CGRectGetMaxY(self.view.frame) - kGeomHeightToolBar - kGeomHeightBigbutton - kGeomMarginMedium;
    _keepLookingButton.frame = frame;
    
    [_middleLabel sizeToFit];
    frame = _middleLabel.frame;
    frame.origin.x = (width(self.view) - width(_middleLabel)) /2;
    frame.origin.y = (height(self.view) - height(_middleLabel)) /2;
    _middleLabel.frame = frame;
    
    
    frame = _textView.frame;
    frame.size.width = width(self.view) *0.75;
    frame.size.height = 110;
    frame.origin.x = (width(self.view) - frame.size.width) /2;
    frame.origin.y = CGRectGetMinY(_middleLabel.frame) - frame.size.height - kGeomMarginMedium;
    _textView.frame = frame;
}

#pragma segues

- (void)goToHome {
    [self performSegueWithIdentifier:@"home" sender:self];
}

- (void)goToContact {
    [self performSegueWithIdentifier:@"contact" sender:self];
}

- (void)goToFavorites {
    NSLog(@"I am already in favorites");
}

- (void)onKeepLookingButtonTapped {

    [self performSegueWithIdentifier:@"home" sender:self];
}







@end
