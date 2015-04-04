//
//  EditPatientViewController.m
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/4/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "EditPatientViewController.h"

@interface EditPatientViewController ()

@end

@implementation EditPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //this will initially prevent the user from editing.
    self.patientNameTextField.enabled = NO;
    self.patientLastNameTextField.enabled = NO;
    self.patientAgeTextField.enabled = NO;

    //need to set the border style to none.
    self.patientNameTextField.borderStyle = UITextBorderStyleNone;
    self.patientLastNameTextField.borderStyle = UITextBorderStyleNone;
    self.patientAgeTextField.borderStyle = UITextBorderStyleNone;

    //retrieve he info for the patient.
    self.patientNameTextField.text = self.editPatient.patientFirstName;
    self.patientLastNameTextField.text = self.editPatient.patientLastName;
    self.patientAgeTextField.text = self.editPatient.patientAge;

}



- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {

    [super cancelAndDismis];
    
}
- (IBAction)editSaveButtonTapped:(id)sender {

    if ([self.editSave.title isEqualToString:@"Edit"]) {


    //need to set the title of the nav bar to edit patient.

        [self setTitle:@"Edit Patient"];
    //need to enable the textfields.
        self.patientNameTextField.enabled = YES;
        self.patientLastNameTextField.enabled = YES;
        self.patientAgeTextField.enabled = YES;

    //set the borders
        self.patientNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.patientLastNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.patientAgeTextField.borderStyle = UITextBorderStyleRoundedRect;

        self.editSave.title = @"Save";


    }else {

        //this will initially prevent the user from editing.
        self.patientNameTextField.enabled = NO;
        self.patientLastNameTextField.enabled = NO;
        self.patientAgeTextField.enabled = NO;

        //need to set the border style to none.
        self.patientNameTextField.borderStyle = UITextBorderStyleNone;
        self.patientLastNameTextField.borderStyle = UITextBorderStyleNone;
        self.patientAgeTextField.borderStyle = UITextBorderStyleNone;

        [self setTitle:@"Patient"];


        self.editPatient.patientFirstName = self.patientNameTextField.text;
        self.editPatient.patientLastName = self.patientLastNameTextField.text;
        self.editPatient.patientAge = self.patientAgeTextField.text;


        //save to coredata. 
        [self saveAndDismiss];
    }
}

@end
