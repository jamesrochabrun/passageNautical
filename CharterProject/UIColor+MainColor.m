//
//  UIColor+MainColor.m
//  CharterProject
//
//  Created by James Rochabrun on 13-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "UIColor+MainColor.h"

@implementation UIColor (MainColor)
+ (UIColor *)customMainColor {
//    return [UIColor colorWithRed:0.455 green:1.000 blue:0.761 alpha:1.000];
    return [UIColor colorWithRed:0.3053 green:0.9038 blue:0.811 alpha:1.0];
}

+ (UIColor *)customTextColor {
    return [UIColor colorWithRed:0.471 green:0.4537 blue:0.3451 alpha:1.0];
}

+ (UIColor *)toolBarButtonColor {
    return  [UIColor colorWithRed:0.4976 green:0.4952 blue:0.5 alpha:1.0];
}

+ (UIColor *)alertColor {
    return [UIColor colorWithRed:1.0 green:0.435 blue:0.4153 alpha:1.0];
}

@end
