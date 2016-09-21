//
//  Common.h
//  CharterProject
//
//  Created by James Rochabrun on 9/21/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSArray * parseArrayOrNullFromServer (id object);
extern NSString * parseStringOrNullFromServer (id object);
extern NSDictionary * parseDictionaryOrNullFromServer (id object);
extern NSNumber * parseNSNumberOrNullFromServer (id object);

@interface Common : NSObject



@end
