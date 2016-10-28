//
//  DetailViewController.h
//  CharterProject
//
//  Created by James Rochabrun on 13-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharterCollectionViewCell.h"
#import "ViewPickerView.h"
@class CharterService;

@interface DetailViewController : UIViewController<CharterCollectionViewCellDelegate, ViewPickerViewDelegate>
@property (nonatomic, strong) CharterService *charterService;



@end
