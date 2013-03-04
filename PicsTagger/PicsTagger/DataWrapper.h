//
//  DataWrapper.h
//  PicsTagger
//
//  Created by Alberto Baggio on 17/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "BundleWrapper.h"
#import <MapKit/MapKit.h>

@interface DataWrapper : NSObject {
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;

+ (DataWrapper*) sharedWrapper;

- (void) createTrack:(int) time;
- (void) setTrackSentStatus: (NSString*) status track:(NSString*)track;
- (void) storePoint:(int)track timestamp:(NSDate*)time latitude:(float)latitude longitude:(float)longitude;
- (void) updateNameTracks:(NSString*)name track:(NSString*)track;
- (void) updateDistanceTracks:(float)distance track:(int)track;
- (void) dataSynchronization;
- (void) deleteTrack:(NSString*)track;

- (NSArray*) trackList;
- (NSArray*) trackData:(NSString*)track;
- (NSArray*) trackPoint:(NSString*)track;
- (NSString*) userTitleForTrack:(NSString*)track;
- (NSString*) lastUpdateTrack:(NSString*)track;


@end
