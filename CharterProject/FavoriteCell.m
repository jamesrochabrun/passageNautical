//
//  FavoriteCell.m
//  CharterProject
//
//  Created by James Rochabrun on 22-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "FavoriteCell.h"
#import "CharterFavorite.h"

@implementation FavoriteCell


- (void)awakeFromNib {
    [super awakeFromNib];
    

}


- (void)configureCellForFavorite:(CharterFavorite *)charterFavorite {
    self.nameLabel.text = charterFavorite.name;
}

@end
