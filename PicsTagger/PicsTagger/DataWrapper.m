//
//  DataWrapper.m
//  PicsTagger
//
//  Created by Alberto Baggio on 17/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "DataWrapper.h"

@implementation DataWrapper

@synthesize managedObjectContext;

static DataWrapper *sharedWrapper = nil;

+ (DataWrapper *) sharedWrapper {
    
    if (sharedWrapper == nil) {
        sharedWrapper = [[super allocWithZone:NULL] init];
    }
    return sharedWrapper;
    
}

+ (id)allocWithZone:(NSZone *)zone {
    
    @synchronized(self) {
        if (sharedWrapper == nil) {
            sharedWrapper = [super allocWithZone:zone];
            return sharedWrapper;
        }
    }
    return nil;
    
}

- (id) init {
    
    self = [super init];
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [app managedObjectContext];
    return self;
    
}

- (void) createTrack:(int) time {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *login = [defaults objectForKey:@"login"];
    [[UIApplication sharedApplication] delegate];
    NSManagedObject *track = [NSEntityDescription insertNewObjectForEntityForName:@"Tracks" inManagedObjectContext:managedObjectContext];
    [track setValue:[NSNumber numberWithInt:time] forKey:@"timestamp"];
    [track setValue:[NSNumber numberWithInt:time] forKey:@"lastupdate"];
    [track setValue:login forKey:@"user"];
    [track setValue:FALSE forKey:@"sent"];
    [track setValue:@"Default Name" forKey:@"name"];
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
}

- (void) setTrackSentStatus: (NSString*) status track:(NSString*)track {
    
    NSMutableArray *fetchResults;
    NSString *entityName= @"Tracks";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"timestamp==%i",[track intValue]]];
    if ([status isEqualToString:@"True"]) {
        [[fetchResults objectAtIndex:0] setValue:[NSNumber numberWithBool:TRUE] forKey:@"sent"];
    }
    if (![managedObjectContext save:nil])
        NSLog(@"Error in storing to database");
    
}

- (NSArray*) trackList {
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tracks" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSMutableArray * fetchResults;
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"user==%@",[[BundleWrapper sharedBundle] userLogin]]];
    return fetchResults;
    
}

- (void) storePoint:(int)track timestamp:(NSDate*)time latitude:(float)latitude longitude:(float)longitude {
    
    NSManagedObject *point = [NSEntityDescription insertNewObjectForEntityForName:@"Points" inManagedObjectContext:managedObjectContext];
    [point setValue:[NSNumber numberWithInt:track] forKey:@"track"];
    [point setValue:time forKey:@"timestamp"];
    [point setValue:[NSNumber numberWithFloat:latitude] forKey:@"latitude"];
    [point setValue:[NSNumber numberWithFloat:longitude] forKey:@"longitude"];
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
}

- (void) updateNameTracks:(NSString*)name track:(NSString*)track {
    
    NSMutableArray *fetchResults;
    NSString *entityName= @"Tracks";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"timestamp==%i",[track intValue]]];
    [[fetchResults objectAtIndex:0] setValue:name forKey:@"name"];
    int time = [[NSDate date] timeIntervalSince1970];
    [[fetchResults objectAtIndex:0] setValue:[NSNumber numberWithInt:time] forKey:@"lastupdate"];
    if (![managedObjectContext save:nil])
        NSLog(@"Error in storing to database");
    
}

- (void) updateDistanceTracks:(float)distance track:(int)track {
    
    NSMutableArray *fetchResults;
    NSString *entityName= @"Tracks";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"timestamp==%i",track ]];
    [[fetchResults objectAtIndex:0] setValue:[NSNumber numberWithFloat:distance] forKey:@"distance"];
    if (![managedObjectContext save:nil])
        NSLog(@"Error in storing to database");
    
}

- (NSString*) userTitleForTrack:(NSString*)track {
    
    NSMutableArray *fetchResults;
    NSString *entityName= @"Tracks";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"timestamp==%i",[track intValue]]];
    return [[fetchResults objectAtIndex:0] valueForKey:@"name"];
    
}

- (NSString*) lastUpdateTrack:(NSString*)track {
    
    NSMutableArray *fetchResults;
    NSString *entityName= @"Tracks";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"timestamp==%i",[track intValue]]];
    return [[fetchResults objectAtIndex:0] valueForKey:@"lastupdate"];
    
}

- (NSArray*) trackPoint:(NSString*)track {
    
    NSMutableArray *fetchResults;
    NSString *entityName= @"Points";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"track==%i",[track intValue]]];
    NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
    for(int i=0; i<fetchResults.count;i++) {
        float lat = [[[fetchResults objectAtIndex:i] valueForKey:@"latitude"] floatValue];
        float lon = [[[fetchResults objectAtIndex:i] valueForKey:@"longitude"] floatValue];
        CLLocation *point = [[CLLocation alloc ] initWithLatitude:lat longitude:lon];
        [pointsArray addObject:point];
    }
    NSArray *back = pointsArray;
    return back;
    
}

- (NSArray*) trackData:(NSString*)track {
    
    NSMutableArray *fetchResults;
    NSString *entityName= @"Tracks";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"timestamp==%i",[track intValue]]];
    return [fetchResults objectAtIndex:0];
    
}

- (void) deleteTrack:(NSString*)track {
    NSMutableArray *fetchResults;
    NSString *entityName= @"Tracks";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"timestamp==%i",[track intValue]]];
    for (NSManagedObject * track in fetchResults) {
        [managedObjectContext deleteObject:track];
    }
    NSError *saveError = nil;
    [managedObjectContext save:&saveError];
    
    entityName= @"Points";
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"track==%i",[track intValue]]];
    for (NSManagedObject * track in fetchResults) {
        [managedObjectContext deleteObject:track];
    }
    saveError = nil;
    [managedObjectContext save:&saveError];
}

- (void) dataSynchronization {
    
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
    
}

@end
