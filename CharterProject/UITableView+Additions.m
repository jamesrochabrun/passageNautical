//
//  UITableView+Additions.m
//  CharterProject
//
//  Created by James Rochabrun on 10/4/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "UITableView+Additions.h"

@implementation UITableView (Additions)

+ (UITableView *)tableViewInView:(UIView *)view delegate:(id)delegate {
    
    UITableView *tableView = [UITableView new];
    
    if (tableView) {
        [view addSubview:tableView];
    }
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
        tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    return tableView;
}

@end
