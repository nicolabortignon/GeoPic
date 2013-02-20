//
//  MapRouteLayer.h
//  PicsTagger
//
//  Created by Alberto Baggio on 20/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapRouteLayer : UIView {
    
    MKMapView * mapView;
    NSArray * points;
    UIColor * lineColor;
    
}

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) NSArray *points;
@property (nonatomic, retain) UIColor *lineColor;

- (id) initWithRoute:(NSArray*)routePoints mapView:(MKMapView*)map;

@end
