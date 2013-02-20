//
//  MapRouteLayer.m
//  PicsTagger
//
//  Created by Alberto Baggio on 20/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "MapRouteLayer.h"

@implementation MapRouteLayer

@synthesize mapView;
@synthesize points;
@synthesize lineColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithRoute:(NSArray*)routePoints mapView:(MKMapView*)map {
    
    self = [super initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setMapView:map];
    [self setPoints:routePoints];
        
    CLLocationDegrees maxLat = -90;
    CLLocationDegrees maxLon = -180;
    CLLocationDegrees minLat = 90;
    CLLocationDegrees minLon = 180;
    
    for (int idx=0; idx < self.points.count; idx++) {
        CLLocation* currentLocation = [self.points objectAtIndex:idx];
        if(currentLocation.coordinate.latitude > maxLat)
            maxLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.latitude < minLat)
            minLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.longitude > maxLon)
            maxLon = currentLocation.coordinate.longitude;
        if(currentLocation.coordinate.longitude < minLon)
            minLon = currentLocation.coordinate.longitude;
        
    }
    
    
    
    MKCoordinateRegion region;
    region.center.latitude = (maxLat + minLat) / 2;
    region.center.longitude = (maxLon + minLon) / 2;
    region.span.latitudeDelta = maxLat - minLat;
    region.span.longitudeDelta = maxLon - minLon;
    
    [self.mapView setRegion:region];
    //[self.mapView setDelegate:self];
    [self.mapView addSubview:self];
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    if(!self.hidden && nil != self.points && self.points.count > 0)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        if(nil == self.lineColor)
            self.lineColor = [UIColor blueColor];
        
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
        CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
        
        // Draw them with a 2.0 stroke width so they are a bit more visible.
        CGContextSetLineWidth(context, 2.0);
        
        for(int idx = 0; idx < self.points.count; idx++)
        {
            CLLocation* location = [self.points objectAtIndex:idx];
            CGPoint point = [mapView convertCoordinate:location.coordinate toPointToView:self];
            
            if(idx == 0)
            {
                // move to the first point
                CGContextMoveToPoint(context, point.x, point.y);
            }
            else
            {
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
        
        CGContextStrokePath(context);
    }
}


@end
