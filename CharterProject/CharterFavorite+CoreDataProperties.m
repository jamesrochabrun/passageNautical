//
//  CharterFavorite+CoreDataProperties.m
//  CharterProject
//
//  Created by James Rochabrun on 22-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CharterFavorite+CoreDataProperties.h"

@implementation CharterFavorite (CoreDataProperties)

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
@dynamic shortCharterDescription;

- (NSString *)sectionName {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateStyle:NSDateFormatterFullStyle];
    NSString *stringDate  = [dateFormat stringFromDate:date];
    return stringDate;
}

@end

