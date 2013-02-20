//
//  BundleWrapper.h
//  PicsTagger
//
//  Created by Alberto Baggio on 18/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BundleWrapper : NSObject {
    NSUserDefaults *bundle;
}

+ (BundleWrapper*) sharedBundle;
- (NSString*) userLogin;
- (NSString*) userPassword;
- (NSString*) userLoged;
- (NSString*) isFirstAcess;

- (void) setLogin: (NSString*)user;
- (void) setLoged: (NSString*)boolean;
- (void) setPassword: (NSString*) md5Pass;
- (void) setFirstAcess: (NSString*) boolean;

@end
