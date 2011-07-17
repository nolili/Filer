//
//  CompositeTableVIewController.h
//  Filer
//
//  Created by ohashi tosikazu on 11/07/14.
//  Copyright 2011 nagoya-bunri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Folder;

@interface CompositeTableVIewController : UITableViewController <NSFetchedResultsControllerDelegate>{
    
}
@property (nonatomic, retain) Folder *currentComposite;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
