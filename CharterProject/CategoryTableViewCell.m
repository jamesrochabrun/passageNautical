//
//  CategoryTableViewCell.m
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCellForInfoArray:(NSArray*)array {
    
    
    //self.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"y"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"y"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill; 
    
    self.backgroundView = imageView;
    
    
    self.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];

}


@end
