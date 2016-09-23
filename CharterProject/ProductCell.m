//
//  ProductCell.m
//  CharterProject
//
//  Created by James Rochabrun on 13-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "ProductCell.h"
#import "CharterService.h"
#import "Charter.h"
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

- (void)configureCellwithCharter:(Charter *)charter {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //background Image of Cell
        
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [imageView setImageWithURL:[NSURL URLWithString:charter.imageURL]
                  placeholderImage:[UIImage imageNamed:@"yate"]];
        
        self.backgroundView.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.backgroundView.layer.shadowOffset = CGSizeMake(5, 5);
        self.backgroundView.layer.shadowOpacity = 1;
        self.backgroundView.layer.shadowRadius = 1.0;
        self.backgroundView = imageView;
        
        //charter service name
        _nameLabel.text = charter.name;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont regularFont:15];
        
        //charter service price
        _priceLabel.text = [NSString stringWithFormat:@"%@ %@" , charter.currency, charter.advertisedPrice];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.font = [UIFont regularFont:15];
        
        //charter service time
        int hours = [charter.durationMinutes intValue] / 60;
        _timeLabel.text = [NSString stringWithFormat:@"%d Hours",hours];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont regularFont:15];
        
    });
    
}














@end
