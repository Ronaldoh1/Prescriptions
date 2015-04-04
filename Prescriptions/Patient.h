//
//  Patient.h
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/3/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Patient : NSManagedObject

@property (nonatomic, retain) NSString * patientFirstName;
@property (nonatomic, retain) NSString * patientLastName;
@property (nonatomic, retain) NSSet *prescriptions;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)addPrescriptionsObject:(NSManagedObject *)value;
- (void)removePrescriptionsObject:(NSManagedObject *)value;
- (void)addPrescriptions:(NSSet *)values;
- (void)removePrescriptions:(NSSet *)values;

@end
