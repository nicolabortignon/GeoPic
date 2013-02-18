//
//  Tracker.m
//  PicsTagger
//
//  Created by Alberto Baggio on 16/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "Tracker.h"

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *login = [defaults objectForKey:@"login"];
    
    [locationManager stopUpdatingLocation];
    NSString *gpx = [[GpxManager sharedManger] createGpx:current_track];
    
    NSLog(@"%@", [[GpxManager sharedManger] createGpx:current_track]);
    
    NSArray       *myPathList        =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString      *myPath            =  [myPathList  objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@_%i", login, current_track];
    fileName = [fileName stringByAppendingString:@".gpx"];
    myPath = [myPath stringByAppendingPathComponent:fileName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:myPath])
    {
        [[NSFileManager defaultManager] createFileAtPath:myPath contents:nil attributes:nil];
        [gpx writeToFile:myPath atomically:NO encoding:NSUTF8StringEncoding error:nil];
    }
    else {
        //produced.text = @"Cannot overwrite existing files";
        
    }
    return [NSString stringWithFormat:@"%i",current_track];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSString *currentLatitude = [[NSString alloc]
                                 initWithFormat:@"%+.6f",
                                 newLocation.coordinate.latitude];
    NSLog(@"%@", currentLatitude);
    
    NSString *currentLongitude = [[NSString alloc]
                                  initWithFormat:@"%+.6f",
                                  newLocation.coordinate.longitude];
    
    NSLog(@"%@", currentLongitude);
    
    [[DataWrapper sharedWrapper] storePoint:current_track timestamp:[NSDate date] latitude:[currentLatitude floatValue] longitude:[currentLongitude floatValue]];
    
    /*
    NSString *currentHorizontalAccuracy =
    [[NSString alloc]
     initWithFormat:@"%+.6f",
     newLocation.horizontalAccuracy];
    
    NSLog(@"%@", currentHorizontalAccuracy);
    
    NSString *currentAltitude = [[NSString alloc]
                                 initWithFormat:@"%+.6f",
                                 newLocation.altitude];
    
    NSLog(@"%@", currentAltitude);
    

    NSString *currentVerticalAccuracy =
    [[NSString alloc]
     initWithFormat:@"%+.6f",
     newLocation.verticalAccuracy];
    
    NSLog(@"%@", currentVerticalAccuracy);
    
    if (startLocation == nil)
        startLocation = newLocation;
    
    CLLocationDistance distanceBetween = [newLocation
                                          distanceFromLocation:startLocation];
    
    NSString *tripString = [[NSString alloc]
                            initWithFormat:@"%f",
                            distanceBetween];
    NSLog(@"%@", tripString);
     */
}

@end
