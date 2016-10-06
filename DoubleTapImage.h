//
//  DoubleTapImage.h
//  CharterProject
//
//  Created by James Rochabrun on 24-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DoubleTapImageDelegate <NSObject>

@optional
- (void)didIamgeDoubleTapped;

@end

@interface DoubleTapImage : UIImageView
@property id<DoubleTapImageDelegate>delegate;
- (instancetype)init;

@end
