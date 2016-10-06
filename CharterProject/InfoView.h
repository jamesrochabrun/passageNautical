//
//  InfoView.h
//  CharterProject
//
//  Created by James Rochabrun on 10/3/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharterService;

@interface InfoView : UIView
@property (nonatomic, strong) UILabel *durationHoursLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *numberOFpeopleLabel;
@property (nonatomic, strong) UIImageView *timeImageView;
@property (nonatomic, strong) UIImageView *peopleImageView;
@property (nonatomic, strong) UIImageView *locationImageView;
@property (nonatomic, strong) CharterService *charter;
@property (nonatomic, strong) UIView *lineView;



@end
