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

@interface DataWrapper : NSObject {
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;

+ (DataWrapper*) sharedWrapper;

- (void) createTrack:(int) time;
- (void) setTrackSentStatus: (NSString*) status track:(NSString*)track;
- (void) storePoint:(int)track timestamp:(NSDate*)time latitude:(float)latitude longitude:(float)longitude;
- (void) updateNameTracks:(NSString*)name track:(NSString*)track;

- (NSArray*) trackList;
- (NSString*) userTitleForTrack:(NSString*)track;


@end
