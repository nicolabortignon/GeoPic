//
//  ProfileViewController.m
//  PicsTagger
//
//  Created by Alberto Baggio on 19/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Profile_568.jpg"]]]; }
    else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"EditDetail_568.jpg"]]];}
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 25, 34, 35)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeProfile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    logOut = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOut setBackgroundImage:[UIImage imageNamed:@"btnStart.png"] forState:UIControlStateNormal];
    [logOut setFrame:CGRectMake(screenSize.width/2 - 50, screenSize.height - 80, 99, 34)];
    [logOut addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOut];

}

- (void) closeProfile {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) logOut {
    
    [[BundleWrapper sharedBundle] setLogin:@""];
    [[BundleWrapper sharedBundle] setLoged:@"False"];
    [[BundleWrapper sharedBundle] setPassword:@""];
    [self.navigationController pushViewController:[[LoginController alloc] init] animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
