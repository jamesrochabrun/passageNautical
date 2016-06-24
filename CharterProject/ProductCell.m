//
//  ProductCell.m
//  CharterProject
//
//  Created by James Rochabrun on 13-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ProductCell.h"
#import "CharterService.h"
#import "CharterFavorite.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"

@interface ProductCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)configureCellwithCharterFavorite:(CharterFavorite*)charterfavorite {
    //background Image of Cell
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImageWithURL:[NSURL URLWithString:charterfavorite.imageURL]
              placeholderImage:[UIImage imageNamed:@"yate"]];
    
    self.backgroundView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.backgroundView.layer.shadowOffset = CGSizeMake(5, 5);
    self.backgroundView.layer.shadowOpacity = 1;
    self.backgroundView.layer.shadowRadius = 1.0;
    self.backgroundView = imageView;
    
    //charter service name
    self.nameLabel.text = charterfavorite.name;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont regularFont:15];
    
    //charter service price
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@" , charterfavorite.currency, charterfavorite.advertisedPrice];
    self.priceLabel.textColor = [UIColor whiteColor];
    self.priceLabel.font = [UIFont regularFont:15];
    
    //charter service time
    int hours = [charterfavorite.durationMinutes intValue] / 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%d Hours",hours];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont regularFont:15];
}














@end
