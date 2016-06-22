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
@dynamic durationMinutes;
@dynamic generalTerms;
@dynamic imageURL;
@dynamic isFavorite;
@dynamic name;
@dynamic shortCharterDescription;
@dynamic latitude;
@dynamic longitude;
@dynamic date;

- (NSString *)sectionName {
    
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:self.date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    NSString *stringDate  = [dateFormatter stringFromDate:date];
    return stringDate;
}
@end
