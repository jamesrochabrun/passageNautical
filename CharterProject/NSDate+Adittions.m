//
//  NSDate+Adittions.m
//  CharterProject
//
//  Created by James Rochabrun on 10/4/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "NSDate+Adittions.h"

@implementation NSDate (Adittions)

-(BOOL) isLaterThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedAscending);
}

-(BOOL) isEarlierThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedDescending);
}
-(BOOL) isLaterThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedDescending);
    
}
-(BOOL) isEarlierThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedAscending);
}

@end
