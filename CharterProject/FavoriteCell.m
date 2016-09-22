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
    
    _nameLabel.text = charterFavorite.name;
    UIImageView *imageView = [UIImageView new];
    [imageView setImageWithURL:[NSURL URLWithString:charterFavorite.imageURL]
              placeholderImage:[UIImage imageNamed:@"yate"]];
    self.backgroundView = imageView;

    //charter service name
    _nameLabel.text = charterFavorite.name;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont regularFont:17];
    
    //charter service price
    _priceLabel.text = [NSString stringWithFormat:@"%@ %@" , charterFavorite.currency, charterFavorite.advertisedPrice];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.font = [UIFont regularFont:17];
    
    //charter service time
    int hours = [charterFavorite.durationMinutes intValue] / 60;
    _durationLabel.text = [NSString stringWithFormat:@"%d Hours",hours];
    _durationLabel.textColor = [UIColor whiteColor];
    _durationLabel.font = [UIFont regularFont:17];

}

@end
