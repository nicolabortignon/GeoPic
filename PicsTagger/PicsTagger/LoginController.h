//
//  LoginController.h
//  PicsTagger
//
//  Created by Alberto Baggio on 16/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialViewController.h"
#import "Login.h"

@interface LoginController : UIViewController <UITextFieldDelegate> {
    
    Login* login;
    UIActivityIndicatorView *activity;
    UITextField *email;
    UITextField *password;
    CGSize screenSize;
    UIButton *button;
    UIImageView *logo;
}

@property (nonatomic, retain) UIActivityIndicatorView *activity;
@property (nonatomic, retain) UITextField *email;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIImageView *logo;

@end
