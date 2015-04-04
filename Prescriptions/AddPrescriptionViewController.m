//
//  AddPrescriptionViewController.m
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/3/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "AddPrescriptionViewController.h"

@interface AddPrescriptionViewController ()


@end

@implementation AddPrescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    [super cancelAndDismis];
}

- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {

    self.addprescription.patient = self.prescriptionPatient;
    self.addprescription.prescriptionName = self.prescriptionName.text;
     self.addprescription.prescriptionInstructions = self.prescriptionInstructions.text;
    [super saveAndDismiss];
}


@end
