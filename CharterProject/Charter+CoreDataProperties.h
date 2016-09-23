//
//  Charter+CoreDataProperties.h
//  CharterProject
//
//  Created by James Rochabrun on 23-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Charter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Charter (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *advertisedPrice;
@property (nullable, nonatomic, retain) NSData *bookingFields;
@property (nullable, nonatomic, retain) NSString *charterDescription;
@property (nullable, nonatomic, retain) NSString *currency;
@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSNumber *durationMinutes;
@property (nullable, nonatomic, retain) NSString *generalTerms;
@property (nullable, nonatomic, retain) NSString *imageURL;
@property (nullable, nonatomic, retain) NSNumber *isFavorite;
@property (nullable, nonatomic, retain) NSString *latitude;
@property (nullable, nonatomic, retain) NSString *longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *productCode;
@property (nullable, nonatomic, retain) NSString *shortCharterDescription;
@property (nullable, nonatomic, retain) NSString *category;

@property (nonatomic, readonly) NSString *sectionName;


@end

NS_ASSUME_NONNULL_END
