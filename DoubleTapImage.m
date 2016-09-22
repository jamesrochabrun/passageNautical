//
//  DoubleTapImage.m
//  CharterProject
//
//  Created by James Rochabrun on 24-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "DoubleTapImage.h"

@interface DoubleTapImage()<UIGestureRecognizerDelegate>

@end
@implementation DoubleTapImage

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [super initWithCoder:aDecoder];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        doubleTap.numberOfTapsRequired= 2;
        self.gestureRecognizers = @[doubleTap];
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
            recognizer.delegate = self;
        }
    }
    return self;
}

-(void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized ||
        gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        [self.delegate didIamgeDoubleTapped];
    }
}


@end
