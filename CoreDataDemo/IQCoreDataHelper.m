//
//  DatabaseManager.m
//  Geo
//
//  Created by Canopus 10 on 4/17/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>

/*************************************/

//Category Methods are used as private methods. Because these are used only inside the class. Not able to access from outside.
//Class method are used because these methods are not dependent upon class iVars.

//Created by Iftekhar. 18/4/13.
@interface CoreDataHelper()

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;

//Save context.
-(BOOL)save;

-(NSArray*)getAllRecordFromTable:(NSString*)table resultType:(NSFetchRequestResultType)resultType;
-(BOOL)saveRecord:(NSDictionary*)recordDict toTable:(NSString*)table;

@end

/*************************************/

//Actual Implementation.
@implementation CoreDataHelper

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:CORE_DATA_MODEL_NAME withExtension:CORE_DATA_MODEL_EXTENSION];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:CORE_DATA_SQLITE_TABLE];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Private Methods

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//Save context.
-(BOOL)save
{
    return [self.managedObjectContext save:nil];
}

-(NSArray*)getAllRecordFromTable:(NSString*)table resultType:(NSFetchRequestResultType)resultType
{
    //Creating fetch request object for fetching records.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:table];
    
    //We are returning configuration in dictionary format. So we retrieve records in dictionary format.
    [fetchRequest setResultType:resultType];
    
    //Executing fetch request. and getting all records.(array of NSManagedObject.
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

-(BOOL)saveRecord:(NSDictionary*)recordDict toTable:(NSString*)table
{
    //creating NSManagedObject for inserting records
    NSManagedObject *aConfiguration = [NSEntityDescription insertNewObjectForEntityForName:table inManagedObjectContext:self.managedObjectContext];
    
    for (NSString *aKey in [recordDict allKeys])
        [aConfiguration setValue:[recordDict objectForKey:aKey] forKey:aKey];
    
    //saving context
    return [self save];
}


#pragma mark - Public Methods

static CoreDataHelper *sharedDataBase;

+(CoreDataHelper*)helper
{
    if (sharedDataBase == nil)
        sharedDataBase = [[CoreDataHelper alloc] init];
    
    return sharedDataBase;
}


-(NSArray*)getAllRecord
{
    return [self getAllRecordFromTable:CORE_DATA_RECORD resultType:NSDictionaryResultType];
}

-(void)saveRecord:(NSDictionary*)eventDict
{
    [self saveRecord:eventDict toTable:CORE_DATA_RECORD];
}


@end