//
//  ProfileViewController.h
//  PicsTagger
//
//  Created by Alberto Baggio on 19/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BundleWrapper.h"
#import "LoginController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface ProfileViewController : UIViewController {

    UIButton *backButton;
    UIButton *logOut;
    UIButton *email;
    UIButton *tellFriend;
    UIButton *rateUs;
    UIButton *credits;
    UIImageView *lines;
    SLComposeViewController *mySLComposerSheet;
    
}

@end
