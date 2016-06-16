//
//  UIFont+CustomFont.m
//  CharterProject
//
//  Created by James Rochabrun on 16-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "UIFont+CustomFont.h"

@implementation UIFont (CustomFont)

+ (UIFont*)regularFont:(int)size {
    return [UIFont fontWithName:@"Gotham Narrow" size:size];
}

+ (UIFont*)mediumFont:(int)size {
    return [UIFont fontWithName:@"GOTHAM-MEDIUM" size:size];
}

@end
