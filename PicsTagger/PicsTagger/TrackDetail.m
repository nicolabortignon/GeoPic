//
//  TrackDetail.m
//  PicsTagger
//
//  Created by Alberto Baggio on 20/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "TrackDetail.h"

@interface TrackDetail ()

@end

@implementation TrackDetail

@synthesize backButton;
@synthesize pathLayer;
@synthesize track_name;

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
    trackDetail = track;
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (screenSize.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"EditDetail_568.jpg"]]];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"EditDetail_568.jpg"]]];
    }
    
    NSArray *trackData = [[DataWrapper sharedWrapper] trackData:trackDetail];
    
    track_name = [[UITextField alloc] initWithFrame:CGRectMake(56, 103, screenSize.width-80, 30)];
    track_name.font = [UIFont systemFontOfSize:15];
    [track_name setText:[trackData valueForKey:@"name"]];
    [track_name setEnabled:NO];
    track_name.autocorrectionType = UITextAutocorrectionTypeNo;
    track_name.keyboardType = UIKeyboardTypeDefault;
    track_name.clearButtonMode = UITextFieldViewModeWhileEditing;
    track_name.returnKeyType = UIReturnKeyDone;
    track_name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    track_name.delegate = self;
    [self.view addSubview:track_name];
    
	backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 25, 34, 35)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, 160, screenSize.width-40, 250)];
    [mapView setDelegate:self];
    mapView.showsUserLocation = NO;
    mapView.userTrackingMode = NO;
    mapView.layer.cornerRadius = 8.0;
    [self.view addSubview:mapView];
    
    pathLayer = [[MapRouteLayer alloc] initWithRoute:[[DataWrapper sharedWrapper] trackPoint:trackDetail] mapView:mapView];
    
    [self.view addSubview:pathLayer];
    [pathLayer setNeedsDisplay];
    
    status = [UIImageView imageViewWithFrame:CGRectMake(18, 158, 76, 77)];
    if( [[trackData valueForKey:@"sent"] boolValue] ) {
        [status setImage:[UIImage imageNamed:@"RibbonGreeen.png"]];
    }
    else {
        [status setImage:[UIImage imageNamed:@"RibbonRed.png"]];
        send = [UIButton buttonWithType:UIButtonTypeCustom];
        [send setBackgroundImage:[UIImage imageNamed:@"SendBtn.png"] forState:UIControlStateNormal];
        [send setFrame:CGRectMake(screenSize.width/2 - 43, screenSize.height - 80, 86, 26)];
        [send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:send];
        
    }
    [self.view addSubview:status];
    
    //[pathLayer drawRect:pathLayer.frame];
    
}

- (void) closeDetail {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) send{
    self.alertView.progressBar.progress = 0;
    [self.alertView show];
    
    [self performSelector:@selector(sendFile) withObject:nil afterDelay:0.1];
}

- (void) sendFile {
    bool send_suceed = [[ConnectionHandler sharedWrapper] uploadTrack:trackDetail];
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
