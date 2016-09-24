//
//  DescriptionViewController.h
//  CharterProject
//
//  Created by James Rochabrun on 16-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"

@interface DescriptionViewController : UIViewController<TopViewDelegate>
@property (nonatomic, strong) NSString *labelDataText;
@property (nonatomic, strong) NSString *textFieldData;


@end
