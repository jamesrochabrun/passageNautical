//
//  Charter+CoreDataProperties.m
//  CharterProject
//
//  Created by James Rochabrun on 23-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Charter+CoreDataProperties.h"

@implementation Charter (CoreDataProperties)

@dynamic advertisedPrice;
@dynamic bookingFields;
@dynamic charterDescription;
@dynamic currency;
@dynamic date;
@dynamic durationMinutes;
@dynamic generalTerms;
@dynamic imageURL;
@dynamic isFavorite;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic productCode;
@dynamic shortCharterDescription;
@dynamic category;


- (NSString *)sectionName {
    
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:self.date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    NSString *stringDate  = [dateFormatter stringFromDate:date];
    return stringDate;
}
@end