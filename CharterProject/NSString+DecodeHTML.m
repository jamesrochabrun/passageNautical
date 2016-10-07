//
//  NSString+DecodeHTML.m
//  CharterProject
//
//  Created by James Rochabrun on 16-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "NSString+DecodeHTML.h"

@implementation NSString (DecodeHTML)

+ (NSString*)decodeHTMLEntities:(NSString*)string {
    
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    return string;
}

+ (NSString *)convertHTMLInString:(NSString *)html {
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

+ (NSString *)trimString:(NSString *)string {
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [string stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}

+ (NSString *)stringFromCurrentDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
    return now;
}

+ (NSString *)stringFromLocalTimeZone:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *localDate = [dateFormatter stringFromDate:date];
    return localDate;
}

+ (NSString *)stringDateFromLocalTimeZone:(NSString *)string {
    
    NSArray *stringArray = [string componentsSeparatedByString: @" "];
    NSString *date = [stringArray firstObject];
    return date;
}

+ (NSString *)stringHourFromLocalTimeZone:(NSString *)string {
    
    NSArray *stringArray = [string componentsSeparatedByString: @" "];
    NSString *time = [stringArray lastObject];
    return time;
}







@end
