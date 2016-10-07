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

- (void)configureCellwithCharterService:(CharterService *)charterService {
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImageWithURL:[NSURL URLWithString:charterService.imageURL]
              placeholderImage:[UIImage imageNamed:@"yate"]];
    
    __weak ProductCell *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //background Image of Cell
        weakSelf.backgroundView = imageView;
        
        //charter service name
        weakSelf.nameLabel.text = charterService.name;
        weakSelf.nameLabel.textColor = [UIColor whiteColor];
        weakSelf.nameLabel.font = [UIFont regularFont:15];
        
        //charter service price
        weakSelf.priceLabel.text = [NSString stringWithFormat:@"%@ %@" , charterService.currency, charterService.advertisedPrice];
        weakSelf.priceLabel.textColor = [UIColor whiteColor];
        weakSelf.priceLabel.font = [UIFont regularFont:15];
        
        //charter service time
        int hours = [charterService.durationMinutes intValue] / 60;
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%d Hours",hours];
        weakSelf.timeLabel.textColor = [UIColor whiteColor];
        weakSelf.timeLabel.font = [UIFont regularFont:15];
        
    });
    
}














@end
