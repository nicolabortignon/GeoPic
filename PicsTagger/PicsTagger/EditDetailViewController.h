//
//  EditDetailViewController.h
//  PicsTagger
//
//  Created by Alberto Baggio on 18/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import <TapkuLibrary/TapkuLibrary.h>
#import "DataWrapper.h"
#import "Tracker.h"
#import "MapRouteLayer.h"

@interface EditDetailViewController : UIViewController <UITextFieldDelegate,MKMapViewDelegate> {
    
    NSString *track_detail;
    UITextField *track_name;
    MKMapView *mapView;
    UIButton *button;
    MapRouteLayer *pathLayer;
    
}

@property (nonatomic, retain) UITextField *track_name;
@property (strong,nonatomic) TKProgressAlertView *alertView;
@property (nonatomic, retain) MapRouteLayer *pathLayer;

- (id)initWithTrack:(NSString*)track;

@end
