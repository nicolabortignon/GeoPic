//
//  BundleWrapper.m
//  PicsTagger
//
//  Created by Alberto Baggio on 18/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "BundleWrapper.h"

@implementation BundleWrapper

static BundleWrapper *sharedBundle = nil;

+ (BundleWrapper *) sharedBundle {
    if (sharedBundle == nil)
    {
        sharedBundle = [[super allocWithZone:NULL] init];
    }
    return sharedBundle;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    
    {
        if (sharedBundle == nil)
            
        {
            sharedBundle = [super allocWithZone:zone];
            return sharedBundle;
        }
    }
    return nil;
}

- (id) init {
    self = [super init];
    bundle = [NSUserDefaults standardUserDefaults];
    return self;
}

- (NSString*) userLogin {
    return [bundle objectForKey:@"login"];
}
- (NSString*) userPassword {
    return [bundle objectForKey:@"password"];
}
- (NSString*) userLoged {
    return [bundle objectForKey:@"loged"];
}

- (NSString*) isFirstAcess {
    return [bundle objectForKey:@"firstAcess"];
}
- (void) setLogin: (NSString*)user {
    [bundle setValue:user forKey:@"login"];
}
- (void) setLoged: (NSString*)boolean {
    NSLog(@"setto loggato");
    [bundle setValue:boolean forKey:@"loged"];
}
- (void) setPassword: (NSString*) md5Pass {
    [bundle setValue:md5Pass forKey:@"password"];
}
- (void) setFirstAcess: (NSString*) boolean {
    [bundle setValue:boolean forKey:@"firstAcess"];
}


@end
