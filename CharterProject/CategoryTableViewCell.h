//
//  CategoryTableViewCell.h
//  CharterProject
//
//  Created by James Rochabrun on 10-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharterService;

@interface CategoryTableViewCell : UITableViewCell
@property UIColor *customColor;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
- (void)configureCellwithArray:(NSArray*)array;



@end
