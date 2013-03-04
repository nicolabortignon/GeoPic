//
//  ConnectionHandler.m
//  PicsTagger
//
//  Created by Alberto Baggio on 22/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "ConnectionHandler.h"

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@implementation ConnectionHandler

static ConnectionHandler *sharedWrapper = nil;

+ (ConnectionHandler *) sharedWrapper {
    
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
    return self;
    
}

#pragma mark  Upload

- (NSDictionary*) post:(NSString*)post_url parameters:(NSArray*)parameters postValue:(NSArray*)values {
    @try {
        NSString *post = @"";
        for (int i=0; i < parameters.count; i++) {
            if (i==0) {
                post = [post stringByAppendingFormat:@"%@=%@", [parameters objectAtIndex:i], [values objectAtIndex:i] ];
            }
            else {
                post = [post stringByAppendingFormat:@"&%@=%@", [parameters objectAtIndex:i], [values objectAtIndex:i] ];
            }
        }
        
        NSURL *url=[NSURL URLWithString:post_url];
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
            return jsonData;
            
        } else {
            //if (error) NSLog(@"Error: %@", error);
            return nil;
        }
    }
    @catch (NSException *e) {
        NSLog(@"Exception: %@", e);
        return nil;
    }
}

- (BOOL) uploadTrack:(NSString*)track_timestamp {
    @try {
        
        NSString *fileName = [NSString stringWithFormat:@"%@", track_timestamp];
        NSString *gpx = [[GpxManager sharedManger] createGpx:[track_timestamp intValue]];
        gpx = [gpx stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        gpx = [gpx stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSString *user = [[BundleWrapper sharedBundle] userLogin];
        NSString *pass = [[BundleWrapper sharedBundle] userPassword];
        NSString *userTitle = [[DataWrapper sharedWrapper] userTitleForTrack:track_timestamp];
        NSString *lastUpdate = [[DataWrapper sharedWrapper] lastUpdateTrack:track_timestamp];
        
        NSArray *parameters = [[NSArray alloc] initWithObjects:@"email",@"password",@"title",@"createTimestamp",@"lastUpdateTimestamp",@"gpx", nil];
        NSArray *postValues = [[NSArray alloc] initWithObjects:user,pass,userTitle,fileName,lastUpdate,gpx, nil];
        
        NSDictionary *jsonReturn = [self post:@"http://www.stopsharing.me/geopic/gpxUpload.php" parameters:parameters postValue:postValues];
        if (jsonReturn == nil) {
            return FALSE;
        }
        else {
            NSString * success = [NSString stringWithFormat:@"%@", [jsonReturn objectForKey:@"code"]];
            if([success isEqualToString:@"correct"]) {
                [[DataWrapper sharedWrapper] setTrackSentStatus:@"True" track:track_timestamp];
                return TRUE;
            }
            else {
                return FALSE;
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

- (void) synchronize {
    
    NSString *user = [[BundleWrapper sharedBundle] userLogin];
    NSString *pass = [[BundleWrapper sharedBundle] userPassword];
    NSArray *parameters = [[NSArray alloc] initWithObjects:@"email",@"password",nil];
    NSArray *postValues = [[NSArray alloc] initWithObjects:user,pass,nil];
    NSArray *jsonReturn = (NSArray*) [self post:@"http://www.stopsharing.me/geopic/synchronize.php" parameters:parameters postValue:postValues];
    if (jsonReturn) {
        
    }
    
}

@end
