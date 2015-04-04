//
//  AddPatientViewController.m
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/3/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "AddPatientViewController.h"
#import "CoreViewController.h"

@interface AddPatientViewController ()


@end

@implementation AddPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {

    [super cancelAndDismis];


}

- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    self.addPatient.patientFirstName = self.patientFirstName.text;
    self.addPatient.patientLastName = self.patientLastName.text;

    [super saveAndDismiss];
}

@end
