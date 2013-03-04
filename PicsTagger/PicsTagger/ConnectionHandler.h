//
//  ConnectionHandler.h
//  PicsTagger
//
//  Created by Alberto Baggio on 22/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataWrapper.h"
#import "BundleWrapper.h"
#import "GpxManager.h"
#import "SBJson.h"

@interface ConnectionHandler : NSObject

+ (ConnectionHandler*) sharedWrapper;

- (BOOL) uploadTrack:(NSString*)track_timestamp;
- (NSDictionary*) post:(NSString*)post_url parameters:(NSArray*)parameters postValue:(NSArray*)values;
- (void) synchronize;
@end
