//
//  ProductCell.h
//  CharterProject
//
//  Created by James Rochabrun on 13-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharterService;

@interface ProductCell : UITableViewCell

- (void)configureCellwithCharterService:(CharterService *)charterFavorite;


@end
