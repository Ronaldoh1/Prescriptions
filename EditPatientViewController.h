//
//  EditPatientViewController.h
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/4/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h" // need access to patient objects.
#import "CoreViewController.h" //need to access out core data objects.s


//need to subclass our CoreViewController for access.
@interface EditPatientViewController : CoreViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editSave;

@property (weak, nonatomic) IBOutlet UITextField *patientNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientLastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *patientAgeTextField;
//need a patient to edit...add a property. This will be assigned a new pointer during the prepared for segue. 
@property Patient *editPatient;

@end
