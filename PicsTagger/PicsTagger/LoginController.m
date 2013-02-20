//
//  LoginController.m
//  PicsTagger
//
//  Created by Alberto Baggio on 16/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

@synthesize activity;
@synthesize email;
@synthesize password;
@synthesize button;
@synthesize logo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"SplashOnlyImage_568.jpg"]]];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"SplashOnlyImage.jpg"]]];
    }
    
    login = [[Login alloc] init];
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activity setFrame:CGRectMake((int) screenBounds.size.width/2 - activity.frame.size.width/2, 20, activity.frame.size.width, activity.frame.size.height)];
    //activity.center = self.view.center;
    [self.view addSubview:activity];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"btnStart.png"] forState:UIControlStateNormal];
    screenSize = [[UIScreen mainScreen] bounds].size;
    
    [button setFrame:CGRectMake(screenSize.width/2 - 50, screenSize.height - 80, 99, 34)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(checkLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(screenSize.width/2 - 130, screenSize.height -200, 260, 40)];
    [email setText:@""];
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.font = [UIFont systemFontOfSize:15];
    email.placeholder = @"email";
    email.autocorrectionType = UITextAutocorrectionTypeNo;
    email.keyboardType = UIKeyboardTypeEmailAddress;
    email.returnKeyType = UIReturnKeyDone;
    email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    email.delegate = self;
    [self.view addSubview:email];
    
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(screenSize.width/2 - 130, screenSize.height -150, 260, 40)];
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.font = [UIFont systemFontOfSize:15];
    password.placeholder = @"password";
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.keyboardType = UIKeyboardTypeDefault;
    password.secureTextEntry = YES;
    password.returnKeyType = UIReturnKeyDone;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.delegate = self;
    [self.view addSubview:password];
	// Do any additional setup after loading the view.
    
    logo = [[UIImageView alloc] initWithFrame:CGRectMake(screenSize.width/2 - 78, screenSize.height - 270, 157, 37)];
    [logo setImage:[UIImage imageNamed:@"geoPic.png"]];
    [self.view addSubview:logo];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField { //Keyboard becomes visible
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.22];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    email.frame = CGRectMake(screenSize.width/2 - 130, screenSize.height -400, 260, 40);
    password.frame = CGRectMake(screenSize.width/2 - 130, screenSize.height -350, 260, 40);
    button.frame = CGRectMake(screenSize.width/2 - 50, screenSize.height - 280, 99, 34);
    logo.frame = CGRectMake(screenSize.width/2 - 78, screenSize.height - 470, 157, 37);
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.22];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    email.frame = CGRectMake(screenSize.width/2 - 130, screenSize.height -200, 260, 40);
    password.frame = CGRectMake(screenSize.width/2 - 130, screenSize.height -150, 260, 40);
    button.frame = CGRectMake(screenSize.width/2 - 50, screenSize.height - 80, 99, 34);
    logo.frame = CGRectMake(screenSize.width/2 - 78, screenSize.height - 270, 157, 37);
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return TRUE;
}

- (void) alertStatus:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"fail"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)loginThread {
    NSString *mail = email.text;
    NSString *pass = [password text];
    if (mail == NULL) {
        mail = @"";
    }
    if(pass == NULL) {
        pass = @"";
    }
    BOOL suceed = [[Login sharedLogin] loginPost:mail password:pass];
    [activity stopAnimating];
    [button setEnabled:YES];
    if (suceed) {
        [self performSelectorOnMainThread:@selector(showTutorial) withObject:nil waitUntilDone:NO];
    }
    else {
        
    }
}

- (void) showTutorial {
    [self.navigationController pushViewController:[[TutorialViewController alloc] init] animated:YES];
}

- (void)checkLogin:(id)sender {
    [activity startAnimating];
    [button setEnabled:NO];
    [self performSelectorOnMainThread:@selector(loginThread) withObject:nil waitUntilDone:YES];
    //[self performSelector:@selector(loginThread) withObject:nil afterDelay:0.1];
}

- (void) viewWillAppear:(BOOL)animated {
    [password setText:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
