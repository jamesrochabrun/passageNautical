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
#import "UIFont+CustomFont.h"

@interface CategoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation CategoryTableViewCell
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

//
//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    
//    
//    
//    
//}

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
        self.backgroundView = imageView;
        //category name label
        if ([charterService.name containsString:@"Full Day"]) {
            _titleLabel.text = @"Full day Charters";
        } else if ([charterService.name containsString:@"Half-Day"]){
            _titleLabel.text = @"Half Day Charters";
        } else if ([charterService.name containsString:@"Nautical Overnight"]) {
            _titleLabel.text = @"Nautical Overnight";
        } else {
            _titleLabel.text = @"Bed & Boat";
        }
        _titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        _titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        _titleLabel.layer.shadowRadius = 3.0f;
        _titleLabel.layer.shadowOpacity = 1;
        _titleLabel.layer.shadowOffset = CGSizeZero;
        _titleLabel.layer.masksToBounds = NO;
        [_titleLabel setFont:[UIFont mediumFont:22]];
        
        //category description Label
        _descriptionLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        _descriptionLabel.font = [UIFont regularFont:14];
        _descriptionLabel.layer.shadowColor = [UIColor customTextColor].CGColor;
        _descriptionLabel.layer.shadowRadius = 5.0f;
        _descriptionLabel.layer.shadowOpacity = 1;
        _descriptionLabel.layer.shadowOffset = CGSizeZero;
        _descriptionLabel.layer.masksToBounds = NO;
        _descriptionLabel.text = @"San Francisco";
    
}









@end
