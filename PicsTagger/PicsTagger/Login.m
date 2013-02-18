//
//  Login.m
//  Login
//
//  Created by Alberto Baggio on 11/02/13.
//  Copyright (c) 2013 Alberto Baggio. All rights reserved.
//

#import "Login.h"
#import <CommonCrypto/CommonDigest.h>

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@implementation Login

static Login *sharedLogin =nil;

+ (Login *) sharedLogin {
    if (sharedLogin == nil)
    {
        sharedLogin = [[super allocWithZone:NULL] init];
    }
    return sharedLogin;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    
    {
        if (sharedLogin == nil)
            
        {
            sharedLogin = [super allocWithZone:zone];
            return sharedLogin;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void) alertStatus:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

- (BOOL)loginPost:(NSString*)user password:(NSString*)password {
    @try {
        if([user isEqualToString:@""] || [password isEqualToString:@""] ) {
            NSLog(@"  qui  ");
            NSString *error_msg = @"Please enter both Username and Password";
            [self performSelectorOnMainThread:@selector(alertStatus:) withObject:error_msg waitUntilDone:NO];
            return FALSE;
        }
        else {
            NSString* md5 = [self md5:password];
            
            NSString *post = [[NSString alloc] initWithFormat:@"email=%@&password=%@",user,md5];
            NSLog(@"PostData: %@",post);
            NSURL *url=[NSURL URLWithString:@"http://www.stopsharing.me/geopic/login.php"];
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
            
            NSLog(@"Response code: %d", [response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                SBJsonParser *jsonParser = [SBJsonParser new];
                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                NSLog(@"%@",jsonData);
                NSString * success = [NSString stringWithFormat:@"%@", [jsonData objectForKey:@"code"]];
                NSLog(@"%@",success);
                if([success isEqualToString:@"correct"])
                {
                    return TRUE;
                } else {
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"message"];
                    [self performSelectorOnMainThread:@selector(alertStatus:) withObject:error_msg waitUntilDone:NO];
                    return FALSE;
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                NSString *error_msg = @"Login Failed";
                [self performSelectorOnMainThread:@selector(alertStatus:) withObject:error_msg waitUntilDone:NO];
                return FALSE;
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSString *error_msg = @"Failed";
        [self performSelectorOnMainThread:@selector(alertStatus:) withObject:error_msg waitUntilDone:NO];
    }
}

@end
