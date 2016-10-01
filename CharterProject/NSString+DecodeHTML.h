//
//  NSString+DecodeHTML.h
//  CharterProject
//
//  Created by James Rochabrun on 16-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DecodeHTML)
+ (NSString*)decodeHTMLEntities:(NSString*)string;
+ (NSString *)convertHTMLInString:(NSString *)html;
+ (NSString *)trimString:(NSString *)string;
+ (NSString *)stringFromCurrentDate;
+ (NSString *)stringFromLocalTimeZone:(NSDate *)date;

@end
