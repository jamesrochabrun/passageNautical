//
//  CategoryTableViewCell.m
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "CharterService.h"

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCellwithArray:(NSArray*)array {
    
    CharterService *charterService = [array firstObject];
    NSDictionary *imagesDictionary = [charterService.images objectAtIndex:0];
    NSString *itemUrl = [imagesDictionary valueForKey:@"itemUrl"];
    NSString *itemUrlWithNoSpaces = [itemUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:itemUrlWithNoSpaces]]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundView = imageView;
    
}


@end
