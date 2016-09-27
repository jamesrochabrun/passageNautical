//
//  DetailViewController.h
//  CharterProject
//
//  Created by James Rochabrun on 13-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharterCollectionViewCell.h"
@class CharterService;

@interface DetailViewController : UIViewController<CharterCollectionViewCellDelegate>
@property CharterService *charterService;



@end
