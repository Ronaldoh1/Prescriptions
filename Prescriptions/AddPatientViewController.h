//
//  AddPatientViewController.h
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/3/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h" //import the subcalass
#import "Patient.h"
#import "AppDelegate.h"

@interface AddPatientViewController : CoreViewController //change the subclass...

@property Patient *addPatient;
@property (weak, nonatomic) IBOutlet UITextField *patientFirstName;
@property (weak, nonatomic) IBOutlet UITextField *patientLastName;

@property (weak, nonatomic) IBOutlet UITextField *patientAge;


@end
