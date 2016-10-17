//
//  ReachabilityManager.h
//  CharterProject
//
//  Created by James Rochabrun on 10/14/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <UIKit/UIKit.h>

@interface ReachabilityManager : NSObject
@property (nonatomic) Reachability *reachability;
@end
