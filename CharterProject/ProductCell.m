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
}

- (void)configureCellwithCharterService:(CharterService*)charterService {
    
    //name of charter service
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    nameLabel.text = charterService.name;
    NSLog(@"que onda %@" , charterService.name);

    nameLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:18];
    [self addSubview:nameLabel];
    
    //background Image of Cell
    NSDictionary *imagesDictionary = [charterService.images objectAtIndex:0];
    NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImageWithURL:[NSURL URLWithString:itemUrlWithNoSpaces]
              placeholderImage:[UIImage imageNamed:@"y"]];
    
    self.backgroundView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.backgroundView.layer.shadowOffset = CGSizeMake(5, 5);
    self.backgroundView.layer.shadowOpacity = 1;
    self.backgroundView.layer.shadowRadius = 1.0;
    self.backgroundView = imageView;
}



@end
