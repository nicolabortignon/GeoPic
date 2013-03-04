//
//  EditDetailViewController.m
//  PicsTagger
//
//  Created by Alberto Baggio on 18/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "EditDetailViewController.h"

@interface EditDetailViewController ()

@end

@implementation EditDetailViewController

@synthesize track_name;
@synthesize pathLayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTrack:(NSString*)track {

    self = [super init];
    track_detail = track;
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"EditDetail_568.jpg"]]];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"EditDetail_568.jpg"]]];
    }
    track_name = [[UITextField alloc] initWithFrame:CGRectMake(56, 103, screenBounds.size.width-95, 30)];
    track_name.font = [UIFont systemFontOfSize:15];
    track_name.placeholder = @"Track Name";
    track_name.autocorrectionType = UITextAutocorrectionTypeNo;
    track_name.keyboardType = UIKeyboardTypeDefault;
    track_name.clearButtonMode = UITextFieldViewModeWhileEditing;
    track_name.returnKeyType = UIReturnKeyDone;
    track_name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    track_name.delegate = self;
    [self.view addSubview:track_name];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, 160, screenSize.width-40, 250)];
    [mapView setDelegate:self];
    mapView.showsUserLocation = NO;
    mapView.userTrackingMode = NO;
    mapView.layer.cornerRadius = 8.0;
    //MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 800, 800);
    //[mapView setRegion:viewRegion animated:YES];
    
    [self.view addSubview:mapView];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"SendBtn.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(screenSize.width/2 - 43, screenSize.height - 80, 86, 26)];
    [button addTarget:self action:@selector(storeName) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    pathLayer = [[MapRouteLayer alloc] initWithRoute:[[DataWrapper sharedWrapper] trackPoint:track_detail] mapView:mapView];
    [self.view addSubview:pathLayer];
    [pathLayer setNeedsDisplay];
    
    if (screenSize.height == 568) {
        
    }
    else {
        [button setFrame:CGRectMake(screenSize.width/2 - 50, screenSize.height - 60, 99, 34)];
    }
    
}

- (void) storeName {
    if( [track_name text] == NULL || [[track_name text] isEqualToString:@""])
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Set a Name!"];
    else {
        [[DataWrapper sharedWrapper] updateNameTracks:[track_name text] track:track_detail];
        
        self.alertView.progressBar.progress = 0;
		[self.alertView show];
        
        [self performSelector:@selector(sendFile) withObject:nil afterDelay:0.1];
        //self.alertView.progressBar.progress = 1;
        //[self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) sendFile {
    bool send_suceed = [[ConnectionHandler sharedWrapper] uploadTrack:track_detail];
    if (send_suceed) {
        self.alertView.progressBar.progress = 1;
        self.alertView.title = @"Sending Data";
    }
    else {
        [self.alertView hide];
        [self performSelector:@selector(unableToSend) withObject:nil afterDelay:1.0];
    }
    [self.alertView hide];
    [self performSelector:@selector(backToMain) withObject:nil afterDelay:0.5];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void) backToMain {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) unableToSend {
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Unable to Sent the Data, try later!"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return TRUE;
}

- (TKProgressAlertView *) alertView{
	if(_alertView==nil){
		_alertView = [[TKProgressAlertView alloc] initWithProgressTitle:@"Sending GPX file."];
	}
	return _alertView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
