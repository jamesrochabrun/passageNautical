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
@property (nonatomic, strong) UIView *frameView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation CategoryTableViewCell
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _frameView = [UIView new];
    _frameView.layer.borderColor = [UIColor customMainColor].CGColor;
    _frameView.layer.borderWidth = 2.0f;
    [self addSubview:_frameView];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    _titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    _titleLabel.layer.shadowRadius = 3.0f;
    _titleLabel.layer.shadowOpacity = 1;
    _titleLabel.layer.shadowOffset = CGSizeZero;
    _titleLabel.layer.masksToBounds = NO;
    [_titleLabel setFont:[UIFont mediumFont:22]];
    [self addSubview:_titleLabel];
    
    _descriptionLabel = [UILabel new];
    _descriptionLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    _descriptionLabel.font = [UIFont regularFont:14];
    _descriptionLabel.layer.shadowColor = [UIColor customTextColor].CGColor;
    _descriptionLabel.layer.shadowRadius = 5.0f;
    _descriptionLabel.layer.shadowOpacity = 1;
    _descriptionLabel.layer.shadowOffset = CGSizeZero;
    _descriptionLabel.layer.masksToBounds = NO;
    _descriptionLabel.text = @"San Francisco";
    [self addSubview:_descriptionLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    CGRect frame = _titleLabel.frame;
    frame.origin.x = (width(self) - width(_titleLabel)) /2;
    frame.origin.y = (height(self) - height(_titleLabel)) /2;
    _titleLabel.frame = frame;
    
    [_descriptionLabel sizeToFit];
    frame.origin.x = (width(self) - width(_descriptionLabel)) /2;
    frame.origin.y = CGRectGetMaxY(_titleLabel.frame);
    _descriptionLabel.frame = frame;
    
    frame = _frameView.frame;
    frame.size.height = height(self) * 0.5;
    frame.size.width = width(self) * 0.65;
    frame.origin.x = (width(self) - frame.size.width) /2;
    frame.origin.y = (height(self) - frame.size.height) /2;
    _frameView.frame = frame;
}


- (void)configureCellwithArray:(NSArray*)array {
    
    
    //we are taking the first object of each array
    CharterService *charterService = [array firstObject];
    NSDictionary *imagesDictionary = [charterService.images objectAtIndex:0];
    NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;

    
    [imageView setImageWithURL:[NSURL URLWithString:itemUrlWithNoSpaces]
              placeholderImage:[UIImage imageNamed:@"yate"]];
    
    
    __weak CategoryTableViewCell *weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.backgroundView = imageView;
        //category name label
        if ([charterService.name containsString:@"Full Day"]) {
            weakSelf.titleLabel.text = @"Full day Charters";
        } else if ([charterService.name containsString:@"Half-Day"]){
            weakSelf.titleLabel.text = @"Half Day Charters";
        } else if ([charterService.name containsString:@"Nautical Overnight"]) {
            weakSelf.titleLabel.text = @"Nautical Overnight";
        } else {
            weakSelf.titleLabel.text = @"Bed & Boat";
        }
    });
}









@end
