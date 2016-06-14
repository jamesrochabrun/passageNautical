//
//  ProductCell.m
//  CharterProject
//
//  Created by James Rochabrun on 13-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ProductCell.h"
#import "CharterService.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MainColor.h"

@implementation ProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.shadowView.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
    
    

    
}

- (void)configureCellwithCharterService:(CharterService*)charterService {
    //background Image of Cell
    NSDictionary *imagesDictionary = [charterService.images objectAtIndex:0];
    NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImageWithURL:[NSURL URLWithString:itemUrlWithNoSpaces]
              placeholderImage:[UIImage imageNamed:@"yate"]];
    
    self.backgroundView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.backgroundView.layer.shadowOffset = CGSizeMake(5, 5);
    self.backgroundView.layer.shadowOpacity = 1;
    self.backgroundView.layer.shadowRadius = 1.0;
    self.backgroundView = imageView;
    
    //charter service name
    self.nameLabel.text = charterService.name;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    
    //charter service price
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@" , charterService.currency, charterService.advertisedPrice];
    self.priceLabel.textColor = [UIColor whiteColor];
    self.priceLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    
    //charter service time
    int hours = [charterService.durationMinutes intValue] / 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%d Hours",hours];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
 
}














@end
