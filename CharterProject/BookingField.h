//
//  BookingField.h
//  CharterProject
//
//  Created by James Rochabrun on 9/23/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookingObject.h"

@interface BookingField : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *labelField;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *lineView;
- (instancetype)initWithLabelName:(NSString *)labelName;
@end
