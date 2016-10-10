//
//  UITableView+Additions.h
//  CharterProject
//
//  Created by James Rochabrun on 10/4/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Additions)
+ (UITableView *)tableViewInView:(UIView *)view delegate:(id)delegate;
- (void)fadeTopAndBottomCellsOnTableViewScroll:(UITableView *)tableView withModifier:(CGFloat)modifier ;
@end
