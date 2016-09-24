//
//  BookingField.h
//  CharterProject
//
//  Created by James Rochabrun on 9/23/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingField : UIView
@property (nonatomic, strong) UILabel *labelField;
@property (nonatomic, strong) UITextField *textField;
- (instancetype)initWithLabelName:(NSString *)labelName;
@end
