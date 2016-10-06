//
//  TableHeaderView.h
//  CharterProject
//
//  Created by James Rochabrun on 10/5/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderView : UIView
@property (nonatomic, strong) UILabel *headerLabel;
- (instancetype)initWithHeaderTitle:(NSString *)title;

@end
