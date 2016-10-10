//
//  UILabel+Additions.m
//  CharterProject
//
//  Created by James Rochabrun on 10/8/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "UILabel+Additions.h"
#import "UIFont+CustomFont.h"

@implementation UILabel (Additions)
+ (UILabel *)labelWithText:(NSString *)text withSize:(int)size inView:(UIView *)view {
    
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [label setFont:[UIFont regularFont:size]];
    [label setTextColor:[UIColor whiteColor]];
    label.text = text;
    [view addSubview:label];
    return label;
}

@end
