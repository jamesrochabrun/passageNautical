//
//  BookingViewController.h
//  CharterProject
//
//  Created by James Rochabrun on 9/23/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
@class CharterService;

@interface BookingViewController : UIViewController<TopViewDelegate>
@property (nonatomic, strong) CharterService *charterService;

@end
