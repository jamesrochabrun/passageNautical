//
//  CommentTextView.h
//  CharterProject
//
//  Created by James Rochabrun on 9/30/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTextView : UIView<UITextViewDelegate>
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextView *textView;
- (instancetype)initWithLabelName:(NSString *)labelName;

@end
