//
//  ViewController.m
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/2/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "PatientsViewController.h"
#import "AppDelegate.h" //to access our core data.
#import "AddPatientViewController.h"
#import "Patient.h"
#import "Prescription.h"
#import "PrescriptionsViewController.h"
#import "EditPatientViewController.h" // need it to access the destination view controller in prepareforsegue.

@interface PatientsViewController ()<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property NSFetchedResultsController *fetchresultsController; // to get data from managed object contexts..it will return an array of objects.

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PatientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //best place to add the fetch request is in the view didload method.
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error! %@", error);
        abort();

    }

}

-(void)viewWillAppear:(BOOL)animated{
    //this will ensure that our table is updated no matter where we come from.

    [self.tableView reloadData];
}
//we are using the UI application class to get the delegate and casting it into a managed object context.
//this code will allow us to refer to the our managed object context.

-(NSManagedObjectContext *) managedObjectContext{
    return [(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

#pragma marks - TableView Delegate Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    Patient *patient = [self.fetchedResultsController objectAtIndexPath:indexPath];

    cell.textLabel.text = patient.patientLastName;
    cell.detailTextLabel.text = patient.patientFirstName;

    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [[self.fetchresultsController sections]count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    id<NSFetchedResultsSectionInfo> SectionInfo = [[self.fetchresultsController sections]objectAtIndex:section];

    return [SectionInfo numberOfObjects];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell* )sender{

    if ([[segue identifier]isEqualToString:@"addPatient"]) {

        UINavigationController *NavController = segue.destinationViewController;
        AddPatientViewController *addPatientVC = (AddPatientViewController *)NavController.topViewController;

        Patient *addPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[self managedObjectContext]];

        addPatientVC.addPatient = addPatient;

    }

    if ([[segue identifier]isEqualToString:@"toPrescriptions"]) {

        // UINavigationController *NavController = segue.destinationViewController;
        PrescriptionsViewController *prescriptionVC = [segue destinationViewController];

        //Patient *addPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[self managedObjectContext]];

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        Patient *selectedPatient =(Patient *)[self.fetchresultsController objectAtIndexPath:indexPath];

        prescriptionVC.selectedPatient = selectedPatient;

    }
    //need to check the segue for editPatient

    if ([[segue identifier]isEqualToString:@"editPatient"]) {

        UINavigationController *navigationController = [segue destinationViewController];
        EditPatientViewController *editPatientVC = (EditPatientViewController*) navigationController.topViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

        Patient *editPatient = (Patient *)[self.fetchresultsController objectAtIndexPath:indexPath];

        editPatientVC.editPatient = editPatient;


    }


}

#pragma mark - Fetch Results Controller Section.

-(NSFetchedResultsController *)fetchedResultsController{
    //check if we have a fetch results controller.
    if (self.fetchresultsController != nil) {
        return self.fetchresultsController;
    }
    //else we need to create it .

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patient" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"patientLastName" ascending:YES];

    NSArray *sortDescriptors = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    fetchRequest.sortDescriptors = sortDescriptors;

    self.fetchresultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];

    self.fetchresultsController.delegate = self;


    return self.fetchresultsController;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self managedObjectContext];

        Patient *patientToDelete = [self.fetchresultsController objectAtIndexPath:indexPath];
        [context deleteObject:patientToDelete];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error! %@", error);
        }
    }

}
#pragma mark - Fetch Results Controller Delegates.


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{

    [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    UITableView *tableView = self.tableView; // temp place holder.

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;


        case NSFetchedResultsChangeUpdate: {
            Patient *changePatient = [self.fetchresultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = changePatient.patientFirstName;
        }
            break;

        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;

        default:
            break;
    }

}
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
        default:
            break;
    }
}



@end
