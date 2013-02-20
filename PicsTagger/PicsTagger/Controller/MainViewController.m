//
//  MainViewController.m
//  PicsTagger
//
//  Created by Alberto Baggio on 15/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize startButton;
@synthesize endButton;
@synthesize history;
@synthesize nameTextField;
@synthesize profile;
@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    running = FALSE;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainPagepiuLoupe_568.png"]]];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"SplashOnlyImage.jpg"]]];
    }
    
    /***    TEST LOGIN ***/
        
    if ([[BundleWrapper sharedBundle] userLoged] == NULL) {
        [self.navigationController pushViewController:[[LoginController alloc] init] animated:YES];
    }
    else {
        if ([[[BundleWrapper sharedBundle] userLoged] isEqualToString:@"False"]) {
            if(loginController == nil) {
                loginController = [[LoginController alloc] init];
            }
            [self.navigationController pushViewController:loginController animated:YES];
        }
        else {
            if ( [[Login sharedLogin] loginPostWithoutMd5:[[BundleWrapper sharedBundle] userLogin] password:[[BundleWrapper sharedBundle] userPassword]] ) {
            }
            else {
                if(loginController == nil) {
                    loginController = [[LoginController alloc] init];
                }
                [self.navigationController pushViewController:[[LoginController alloc] init]  animated:YES];
            }
        }
    }
    
    /******* --------------------- *******/
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    rotator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLoader.png"]];
    [rotator setFrame:CGRectMake(screenSize.width/2 - 33, screenSize.height - 170, 67, 67)];
    [self.view addSubview:rotator];
    
    startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [startButton setFrame:CGRectMake(screenSize.width/2 - 33, screenSize.height - 170, 67, 67)];
    
    
    [self.view addSubview:startButton];
    [startButton addTarget:self action:@selector(actionButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    
    history = [UIButton buttonWithType:UIButtonTypeCustom];
    [history setBackgroundImage:[UIImage imageNamed:@"history_button.jpg"] forState:UIControlStateNormal];
    [history setFrame:CGRectMake(0, screenSize.height - 95, 160, 75)];
    [history addTarget:self action:@selector(showHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:history];
    
    profile = [UIButton buttonWithType:UIButtonTypeCustom];
    [profile setBackgroundImage:[UIImage imageNamed:@"profile.jpg"] forState:UIControlStateNormal];
    [profile setFrame:CGRectMake(160, screenSize.height - 95, 160, 75)];
    [profile addTarget:self action:@selector(showProfile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:profile];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(screenSize.width/2 - 80, 132, 160, 160)];
    [mapView setDelegate:self];
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = YES;
    mapView.zoomEnabled = NO;
    mapView.scrollEnabled = NO;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 5000, 5000);
    [mapView setRegion:viewRegion animated:YES];
    [mapView.layer setMasksToBounds:YES];
    [mapView.layer setCornerRadius:80.0];
    [self.view addSubview:mapView];
    
    city = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, screenSize.width, 30)];
    [city setBackgroundColor:[UIColor clearColor]];
    city.font = [UIFont systemFontOfSize:16];
    city.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    city.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    city.textColor = [UIColor whiteColor];
    [city setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:city];
        
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    CLLocation *loc = locationManager.location;
    CLGeocoder * name = [[CLGeocoder alloc] init];
    [name reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error){
                   if(!error){
                       for(CLPlacemark *placemark in placemarks) {
                           NSString* city1 =  [placemark.addressDictionary objectForKey:(NSString*) kABPersonAddressCityKey];
                           [city setText:city1];
                       }
                   }
                   else {
                       NSLog(@"There was a reverse geocoding error\n%@", [error localizedDescription]);
                   }
               }
     ];
    
    
    
    
}

- (void) actionButtonPushed {
    
    if(running) {
        running = FALSE;
        [self endTracking];
        [startButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    else {
        running = TRUE;
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Start Tracking!"];
        [self startTracking];
        [startButton setBackgroundImage:[UIImage imageNamed:@"pauseButton.png"] forState:UIControlStateNormal];
        [self animating];
    }
    
}

- (void)animating {
    if(running) {
        int p = round([[NSDate date] timeIntervalSince1970]);
        [self rotateImage:rotator duration:1.0 curve:UIViewAnimationCurveLinear degrees:( (p % 360) )];
        [self performSelector:@selector(animating) withObject:nil afterDelay:1.0];
    }
}

- (void)rotateImage:(UIImageView *)image duration:(NSTimeInterval)duration
              curve:(int)curve degrees:(CGFloat)degrees
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI*degrees/180);
    image.transform = CGAffineTransformMakeRotation(degrees);
    
    // Commit the changes
    [UIView commitAnimations];

}

- (void) showProfile {
    [self.navigationController pushViewController:[[ProfileViewController alloc] init] animated:YES];
    /*NSLog(@"logout");
    [[BundleWrapper sharedBundle] setLogin:@""];
    [[BundleWrapper sharedBundle] setLoged:@"False"];
    [[BundleWrapper sharedBundle] setPassword:@""];
    if(loginController == nil) {
        loginController = [[LoginController alloc] init];
    }
    [self.navigationController pushViewController:loginController animated:YES];*/

}

- (void) showHistory {
    [self.navigationController pushViewController:[[HistoryControllerViewController alloc] init] animated:YES];
}

- (void) startTracking {
    [[Tracker sharedTracker] startTracking];
}

- (void) endTracking {
    
    last_track = [[Tracker sharedTracker] endTracking];
    [self.navigationController pushViewController:[[EditDetailViewController alloc] initWithTrack:last_track] animated:YES];
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[DataWrapper sharedWrapper] updateNameTracks:[nameTextField text] track:last_track];
    [[Tracker sharedTracker] sendTracking_file:last_track];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
