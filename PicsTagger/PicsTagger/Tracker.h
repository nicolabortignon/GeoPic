//
//  Tracker.h
//  PicsTagger
//
//  Created by Alberto Baggio on 16/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DataWrapper.h"
#import "GpxManager.h"

@interface Tracker : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *startLocation;
    int current_track;
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *startLocation;

+ (Tracker *) sharedTracker;
- (void)startTracking;
- (NSString*)endTracking;

@end
