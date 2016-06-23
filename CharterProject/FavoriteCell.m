//
//  FavoriteCell.m
//  CharterProject
//
//  Created by James Rochabrun on 22-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "FavoriteCell.h"
#import "CharterFavorite.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+MainColor.h"
#import "UIFont+CustomFont.h"


@implementation FavoriteCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}


- (void)configureCellForFavorite:(CharterFavorite *)charterFavorite {
    
    self.nameLabel.text = charterFavorite.name;
    UIImageView *imageView = [UIImageView new];
    [imageView setImageWithURL:[NSURL URLWithString:charterFavorite.imageURL]
              placeholderImage:[UIImage imageNamed:@"yate"]];
    self.backgroundView = imageView;

    //charter service name
    self.nameLabel.text = charterFavorite.name;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont regularFont:17];
    
    //charter service price
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@" , charterFavorite.currency, charterFavorite.advertisedPrice];
    self.priceLabel.textColor = [UIColor whiteColor];
    self.priceLabel.font = [UIFont regularFont:17];
    
    //charter service time
    int hours = [charterFavorite.durationMinutes intValue] / 60;
    self.durationLabel.text = [NSString stringWithFormat:@"%d Hours",hours];
    self.durationLabel.textColor = [UIColor whiteColor];
    self.durationLabel.font = [UIFont regularFont:17];

}

@end
