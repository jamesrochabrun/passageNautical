//
//  CommentsObject.h
//  CharterProject
//
//  Created by James Rochabrun on 9/29/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsObject : NSObject

@property (nonatomic, strong) NSString *comments;
- (NSString *)stringFromCommentsObject;

@end
