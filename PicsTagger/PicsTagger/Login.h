//
//  Login.h
//  Login
//
//  Created by Alberto Baggio on 11/02/13.
//  Copyright (c) 2013 Alberto Baggio. All rights reserved.
//
//  Singleton which implements the authentication procedures
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "BundleWrapper.h"
#import <TapkuLibrary/TapkuLibrary.h>

@interface Login : NSObject

+ (Login *) sharedLogin;
- (BOOL)loginPost:(NSString*)user password:(NSString*)password;
- (BOOL)loginPostWithoutMd5:(NSString*)user password:(NSString*)password;

@end
