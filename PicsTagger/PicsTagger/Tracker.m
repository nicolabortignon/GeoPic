//
//  Tracker.m
//  PicsTagger
//
//  Created by Alberto Baggio on 16/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "Tracker.h"

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@implementation Tracker

@synthesize locationManager;
@synthesize startLocation;

static Tracker *sharedTracker =nil;

+ (Tracker *) sharedTracker {
    if (sharedTracker == nil)
    {
        sharedTracker = [[super allocWithZone:NULL] init];
    }
    return sharedTracker;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    
    {
        if (sharedTracker == nil)
            
        {
            sharedTracker = [super allocWithZone:zone];
            return sharedTracker;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)startTracking {
    current_track = [[NSDate date] timeIntervalSince1970];
    [[DataWrapper sharedWrapper] createTrack:current_track];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 5.0f;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    startLocation = nil;
}

- (NSString*)endTracking {
    
    [locationManager stopUpdatingLocation];
    return [NSString stringWithFormat:@"%i",current_track];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSString *currentLatitude = [[NSString alloc] initWithFormat:@"%+.6f",newLocation.coordinate.latitude];
    NSString *currentLongitude = [[NSString alloc] initWithFormat:@"%+.6f", newLocation.coordinate.longitude];
    [[DataWrapper sharedWrapper] storePoint:current_track timestamp:[NSDate date] latitude:[currentLatitude floatValue] longitude:[currentLongitude floatValue]];
    //NSString *currentAltitude = [[NSString alloc] initWithFormat:@"%+.6f",newLocation.altitude];
    if (startLocation == nil)
        startLocation = newLocation;
    CLLocationDistance distanceBetween = [newLocation distanceFromLocation:startLocation];
    [[DataWrapper sharedWrapper] updateDistanceTracks:distanceBetween track:current_track];
    //NSString *tripString = [[NSString alloc] initWithFormat:@"%f", distanceBetween];
    
}

@end
