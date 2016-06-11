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
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [imageView setImageWithURL:[NSURL URLWithString:itemUrlWithNoSpaces]
              placeholderImage:[UIImage imageNamed:@"y"]];
        
    self.backgroundView = imageView;
    
}


@end
