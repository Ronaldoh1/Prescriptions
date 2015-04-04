//
//  ViewController.h
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/2/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface PatientsViewController : UIViewController
@property Patient *patient;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

