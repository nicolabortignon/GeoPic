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
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSString *login = [defaults objectForKey:@"login"];
    
    [locationManager stopUpdatingLocation];
    /*
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
        
    } */
    return [NSString stringWithFormat:@"%i",current_track];
}


-(bool) sendTracking_file:(NSString*)timestamp {
    @try {
        
        NSString *fileName = [NSString stringWithFormat:@"%@_%@", [[BundleWrapper sharedBundle] userLogin], timestamp];
        NSString *gpx = [[GpxManager sharedManger] createGpx:[timestamp intValue]];
        NSString *user = [[BundleWrapper sharedBundle] userLogin];
        NSString *pass = [[BundleWrapper sharedBundle] userPassword];
        NSString *userTitle = [[DataWrapper sharedWrapper] userTitleForTrack:timestamp];
        NSString *post = [[NSString alloc] initWithFormat:@"email=%@&password=%@&title=%@&filename=%@&gpx=%@",user,pass,userTitle,fileName,gpx];
        NSURL *url=[NSURL URLWithString:@"http://www.stopsharing.me/geopic/gpxUpload.php"];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
            
        [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            SBJsonParser *jsonParser = [SBJsonParser new];
            NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
            NSString * success = [NSString stringWithFormat:@"%@", [jsonData objectForKey:@"code"]];
            if([success isEqualToString:@"correct"])
            {
                NSLog(@"File inviato al server");
                [[DataWrapper sharedWrapper] setTrackSentStatus:@"True" track:timestamp];
                return TRUE;
            } else {
                NSString *error_msg = (NSString *) [jsonData objectForKey:@"message"];
                NSLog(@"%@", error_msg);
                return FALSE;
            }
                
        } else {
            if (error) NSLog(@"Error: %@", error);
                return FALSE;
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSString *currentLatitude = [[NSString alloc] initWithFormat:@"%+.6f",newLocation.coordinate.latitude];
    NSString *currentLongitude = [[NSString alloc] initWithFormat:@"%+.6f", newLocation.coordinate.longitude];
    [[DataWrapper sharedWrapper] storePoint:current_track timestamp:[NSDate date] latitude:[currentLatitude floatValue] longitude:[currentLongitude floatValue]];
    //NSString *currentAltitude = [[NSString alloc] initWithFormat:@"%+.6f",newLocation.altitude];
    if (startLocation == nil)
        startLocation = newLocation;
    CLLocationDistance distanceBetween = [newLocation distanceFromLocation:startLocation];
    NSString *tripString = [[NSString alloc] initWithFormat:@"%f", distanceBetween];
    NSLog(@"%@", tripString);
    
}

@end
