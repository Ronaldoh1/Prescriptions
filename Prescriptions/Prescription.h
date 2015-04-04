//
//  Prescription.h
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/3/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Prescription : NSManagedObject

@property (nonatomic, retain) NSString * prescriptionName;
@property (nonatomic, retain) NSString * prescriptionInstructions;
@property (nonatomic, retain) Patient *patient;

@end
