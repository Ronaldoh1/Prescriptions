//
//  PrescriptionsViewController.m
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/3/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "PrescriptionsViewController.h"
#import "AppDelegate.h"
#import "AddPrescriptionViewController.h"


@interface PrescriptionsViewController ()<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic)  NSManagedObjectContext *managedObjectContext;
@property NSFetchedResultsController *fetchedResultsControllers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PrescriptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error! %@", error);
        abort();

    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(NSManagedObjectContext *) managedObjectContext{
    return [(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addPrescription"]) {
        UINavigationController *navigationController = [segue destinationViewController];

        AddPrescriptionViewController *addPrescriptionVC  = (AddPrescriptionViewController *)navigationController.topViewController;

        Prescription *addPrescription = [NSEntityDescription insertNewObjectForEntityForName:@"Prescription" inManagedObjectContext:[self managedObjectContext]];

        addPrescriptionVC.prescriptionPatient = self.selectedPatient;
        addPrescriptionVC.addprescription = addPrescription;

        

    }
}

#pragma marks - TableView Delegate Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    Prescription *prescription = [self.fetchedResultsControllers objectAtIndexPath:indexPath];
    cell.textLabel.text = prescription.prescriptionName;
    cell.detailTextLabel.text = prescription.prescriptionInstructions;

    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [[self.fetchedResultsControllers sections]count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    id<NSFetchedResultsSectionInfo> SectionInfo = [[self.fetchedResultsControllers sections]objectAtIndex:section];

    return [SectionInfo numberOfObjects];
}



#pragma mark - Fetch Results Controller Section.

-(NSFetchedResultsController *)fetchedResultsController{
    //check if we have a fetch results controller.
    if (self.fetchedResultsControllers != nil) {
        return self.fetchedResultsControllers;
    }
    //else we need to create it .

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Prescription" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"prescriptionName" ascending:YES];
    //create the predicate.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"patient = %@",self.selectedPatient];
    [fetchRequest setPredicate:predicate];

    NSArray *sortDescriptors = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    fetchRequest.sortDescriptors = sortDescriptors;

    self.fetchedResultsControllers = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];

    self.fetchedResultsControllers.delegate = self;


    return self.fetchedResultsControllers;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self managedObjectContext];

        Patient *patientToDelete = [self.fetchedResultsControllers objectAtIndexPath:indexPath];
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
            Prescription *changePrescription = [self.fetchedResultsControllers objectAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = changePrescription.prescriptionName;
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
