//
//  PrescriptionsViewController.h
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/3/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "PatientsViewController.h"
#import "Prescription.h"

@interface PrescriptionsViewController : UIViewController
@property Patient* selectedPatient;

@end
