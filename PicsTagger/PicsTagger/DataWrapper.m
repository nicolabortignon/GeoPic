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
    if (sharedWrapper == nil)
    {
        sharedWrapper = [[super allocWithZone:NULL] init];
    }
    return sharedWrapper;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    
    {
        if (sharedWrapper == nil)
            
        {
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
    NSLog(@"%i", time);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *login = [defaults objectForKey:@"login"];
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObject *track = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"Tracks"
                                       inManagedObjectContext:managedObjectContext];
    [track setValue:[NSNumber numberWithInt:time] forKey:@"timestamp"];
    [track setValue:login forKey:@"user"];
    [track setValue:FALSE forKey:@"sent"];
    [track setValue:@"Default Name" forKey:@"name"];
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (NSArray*) trackList {
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Tracks" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *trackList = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return trackList;
}

- (void) storePoint:(int)track timestamp:(NSDate*)time latitude:(float)latitude longitude:(float)longitude {
    NSLog(@"store %@", time);
    NSManagedObject *point = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Points"
                              inManagedObjectContext:managedObjectContext];
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
    NSLog(@"%@, %@", track, name);
    NSMutableArray *fetchResults;
    NSString *entityName= @"Tracks";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    fetchResults = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
    
    [fetchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"timestamp==%i",[track intValue]]];
    [[fetchResults objectAtIndex:0] setValue:name forKey:@"name"];
    if (![managedObjectContext save:nil])
        NSLog(@"Error in storing to database");
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
