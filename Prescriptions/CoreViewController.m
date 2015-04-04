//
//  CoreViewController.m
//  Prescriptions
//
//  Created by Ronald Hernandez on 4/3/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "CoreViewController.h"
#import "AppDelegate.h"
@interface CoreViewController();

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation CoreViewController


-(NSManagedObjectContext *)managedObjectContext{

  //  return [(AppDelegate*)[UIApplication sharedApplication]managedObjectContext];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    return managedObjectContext;
}

-(void)cancelAndDismis{
    //need to remove the object that was created.
   // [self.managedObjectContext rollback];


    //dissmisses the modal view controller
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)saveAndDismiss{


    NSError *error = nil;

    if([self.managedObjectContext hasChanges]){
        if(![self.managedObjectContext save:&error]){//save failed.
            NSLog(@"Save Failed: %@", [error localizedDescription]);
        }else {
            NSLog(@"Save has successed");
        }
    }


    //dismisses the modal view controller.
     [self dismissViewControllerAnimated:YES completion:nil];

}

@end
