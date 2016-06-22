//
//  CharterFavorite+CoreDataProperties.h
//  
//
//  Created by James Rochabrun on 22-06-16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CharterFavorite.h"

NS_ASSUME_NONNULL_BEGIN

@interface CharterFavorite (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *advertisedPrice;
@property (nullable, nonatomic, retain) NSString *generalTerms;
@property (nullable, nonatomic, retain) NSString *charterDescription;
@property (nullable, nonatomic, retain) NSString *currency;
@property (nullable, nonatomic, retain) NSString *shortCharterDescription;
@property (nullable, nonatomic, retain) NSString *latitude;
@property (nullable, nonatomic, retain) NSString *longitude;
@property (nullable, nonatomic, retain) NSNumber *durationMinutes;
@property (nullable, nonatomic, retain) NSString *imageURL;
@property (nullable, nonatomic, retain) NSData *bookingFields;
@property (nullable, nonatomic, retain) NSNumber *isFavorite;

@end

NS_ASSUME_NONNULL_END
