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
    
    CharterService *charterService = [array firstObject];
    NSDictionary *imagesDictionary = [charterService.images objectAtIndex:0];
    NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //background Image of mainCell
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImageWithURL:[NSURL URLWithString:itemUrlWithNoSpaces]
              placeholderImage:[UIImage imageNamed:@"y"]];
    
    self.backgroundView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.backgroundView.layer.shadowOffset = CGSizeMake(5, 5);
    self.backgroundView.layer.shadowOpacity = 1;
    self.backgroundView.layer.shadowRadius = 1.0;
    self.backgroundView = imageView;
    
    //Title Label
    UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    headingLabel.center = CGPointMake(self.contentView.bounds.size.width/2,self.contentView.bounds.size.height/2);
   
    headingLabel.text = @"Nautical Overnights";
    headingLabel.textAlignment = NSTextAlignmentCenter;
    headingLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    headingLabel.font = [UIFont fontWithName:@"Gotham Medium" size:25];
    headingLabel.layer.borderColor = [UIColor customMainColor].CGColor;
    headingLabel.layer.borderWidth = 3.0;

    [self addSubview:headingLabel];
    
    //description Label
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    descriptionLabel.center = CGPointMake(self.contentView.bounds.size.width/2 ,(self.contentView.bounds.size.height/2 + 30));
    descriptionLabel.text = @"full day";
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    descriptionLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:18];

    
    [self addSubview:descriptionLabel];
}









@end
