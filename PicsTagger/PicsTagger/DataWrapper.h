//
//  DataWrapper.h
//  PicsTagger
//
//  Created by Alberto Baggio on 17/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DataWrapper : NSObject {
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;

+ (DataWrapper*) sharedWrapper;
- (void) createTrack:(int) time;
- (void) storePoint:(int)track timestamp:(NSDate*)time latitude:(float)latitude longitude:(float)longitude;
- (NSArray*) trackList;
- (void) updateNameTracks:(NSString*)name track:(NSString*)track;

@end
