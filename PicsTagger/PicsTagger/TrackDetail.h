//
//  TrackDetail.h
//  PicsTagger
//
//  Created by Alberto Baggio on 20/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import <TapkuLibrary/TapkuLibrary.h>
#import "MapRouteLayer.h"
#import "ConnectionHandler.h"
#import "DataWrapper.h"

@interface TrackDetail : UIViewController <MKMapViewDelegate, UITextFieldDelegate> {
    
    NSString *trackDetail;
    UIButton *backButton;
    MKMapView *mapView;
    MapRouteLayer *pathLayer;
    UITextField *track_name;
    UIImageView *status;
    UIButton *send;
}

@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) MapRouteLayer *pathLayer;
@property (nonatomic, retain) UITextField *track_name;
@property (strong,nonatomic) TKProgressAlertView *alertView;


- (id)initWithTrack:(NSString*)track;

@end
