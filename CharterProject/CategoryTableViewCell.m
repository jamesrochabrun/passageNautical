//
//  CategoryTableViewCell.m
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "CharterService.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MainColor.h"




@implementation CategoryTableViewCell
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)configureCellwithArray:(NSArray*)array {
    
    //we are taking the first object of each array
    CharterService *charterService = [array firstObject];
    NSDictionary *imagesDictionary = [charterService.images objectAtIndex:0];
    NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //background Image of mainCell
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImageWithURL:[NSURL URLWithString:itemUrlWithNoSpaces]
              placeholderImage:[UIImage imageNamed:@"yate"]];
    self.backgroundView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.backgroundView.layer.shadowOffset = CGSizeMake(5, 5);
    self.backgroundView.layer.shadowOpacity = 1;
    self.backgroundView.layer.shadowRadius = 1.0;
    self.backgroundView = imageView;
    //category name label
    if ([charterService.name containsString:@"Full Day"]) {
        self.titleLabel.text = @"Full day Charters";
    } else if ([charterService.name containsString:@"Half-Day"]){
        self.titleLabel.text = @"Half Day Charters";
    } else if ([charterService.name containsString:@"Nautical Overnight"]) {
        self.titleLabel.text = @"Nautical Overnight";
    } else {
        self.titleLabel.text = @"Bed & Boat";
    }
    self.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    self.titleLabel.font = [UIFont fontWithName:@"Gotham Medium" size:18];
    self.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.titleLabel.layer.shadowRadius = 3.0f;
    self.titleLabel.layer.shadowOpacity = 1;
    self.titleLabel.layer.shadowOffset = CGSizeZero;
    self.titleLabel.layer.masksToBounds = NO;
    
    //category description Label
//    self.descriptionLabel.text = @"full day";
    self.descriptionLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    self.descriptionLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:14];
    self.descriptionLabel.layer.shadowColor = [UIColor customTextColor].CGColor;
    self.descriptionLabel.layer.shadowRadius = 5.0f;
    self.descriptionLabel.layer.shadowOpacity = 1;
    self.descriptionLabel.layer.shadowOffset = CGSizeZero;
    self.descriptionLabel.layer.masksToBounds = NO;

}









@end
