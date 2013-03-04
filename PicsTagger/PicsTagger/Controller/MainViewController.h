//
//  MainViewController.h
//  PicsTagger
//
//  Created by Alberto Baggio on 15/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TutorialViewController.h"
#import "LoginController.h"
#import "Tracker.h"
#import "HistoryControllerViewController.h"
#import "BundleWrapper.h"
#import "Login.h"
#import <TapkuLibrary/TapkuLibrary.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "EditDetailViewController.h"
#import "ProfileViewController.h"
#import "ConnectionHandler.h"

@interface MainViewController : UIViewController <MKMapViewDelegate> {
    
    UIButton *startButton;
    UIButton *endButton;
    UIButton *history;
    UIButton *profile;
    Tracker *tracker;
    UITextField *nameTextField;
    LoginController * loginController;
    MKMapView *mapView;
    NSString *last_track;
    UILabel *city;
    UIImageView *rotator;
    bool running;
    
}

@property (nonatomic,retain) UIButton *startButton;
@property (nonatomic, retain) UIButton *endButton;
@property (nonatomic, retain) UIButton *history;
@property (nonatomic, retain) UITextField *nameTextField;
@property (nonatomic, retain) UIButton *profile;
@property (nonatomic, retain) MKMapView *mapView;

@end
