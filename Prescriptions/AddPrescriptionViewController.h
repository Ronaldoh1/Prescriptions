//
//  AddPrescriptionViewController.h
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/3/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"
#import "Patient.h"
#import "AppDelegate.h"
#import "Prescription.h"

@interface AddPrescriptionViewController : CoreViewController
@property Patient *prescriptionPatient;
@property Prescription *addprescription;
@property (weak, nonatomic) IBOutlet UITextField *prescriptionName;
@property (weak, nonatomic) IBOutlet UITextField *prescriptionInstructions;


@end
