//
//  GpxManager.m
//  PicsTagger
//
//  Created by Alberto Baggio on 17/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "GpxManager.h"

@implementation GpxManager

static GpxManager* sharedManger = nil;

+ (GpxManager *) sharedManger {
    if (sharedManger == nil)
    {
        sharedManger = [[super allocWithZone:NULL] init];
    }
    return sharedManger;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    
    {
        if (sharedManger == nil)
            
        {
            sharedManger = [super allocWithZone:zone];
            return sharedManger;
        }
    }
    return nil;
}

- (id) init {
    self = [super init];
    return self;
}

- (NSString*) createGpx:(int)track {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'Z'"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *login = [defaults objectForKey:@"login"];
    NSString *gpx_name = [NSString stringWithFormat:@"%@_%i", login, track];
    
    XMLWriter * xmlWrite = [[XMLWriter alloc] init];    
    
    [xmlWrite writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
    
    [xmlWrite writeStartElement:@"gpx"];
        [xmlWrite writeAttribute:@"version" value:@"1.1"];
        [xmlWrite writeAttribute:@"creator" value:@"cappuccino at work"];
        [xmlWrite writeAttribute:@"xmlns" value:@"http://www.topografix.com/GPX/1/1/"];
        [xmlWrite writeAttribute:@"xmlns:xsi" value:@"http://www.w3.org/TR/xmlschema-1/"];
        [xmlWrite writeAttribute:@"xsi:schemaLocation" value:@"http://www.topografix.com/GPX/1/1/gpx.xsd"];
    
        [xmlWrite writeStartElement:@"trk"]; // Open trk
    
            [xmlWrite writeStartElement:@"name"]; // Open name
                [xmlWrite writeCharacters:[NSString stringWithFormat:@"%@", gpx_name]];
            [xmlWrite writeEndElement]; // Close name
    
            [xmlWrite writeStartElement:@"trkseg"]; // Open trkseg
    
    /* QUI SCRIVI TUTTI I PUNTI */
    
    NSFetchRequest * points = [[NSFetchRequest alloc] init];
    NSString * predicateString = [NSString stringWithFormat:@"track='%i'",track];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    [points setPredicate:predicate];
    [points setEntity:[NSEntityDescription entityForName:@"Points" inManagedObjectContext:[[DataWrapper sharedWrapper] managedObjectContext]]];
    NSMutableArray *resultArray = [[NSMutableArray alloc]initWithArray:[[[DataWrapper sharedWrapper] managedObjectContext] executeFetchRequest:points error:nil]];
    for (int i=0; i<[resultArray count]; i++) {
        NSString * gregorian = [formatter stringFromDate:[[resultArray objectAtIndex:i] valueForKey:@"timestamp"] ];
        [xmlWrite writeStartElement:@"trkpt"];
            [xmlWrite writeAttribute:@"lat" value:[NSString stringWithFormat:@"%@", [[resultArray objectAtIndex:i] valueForKey:@"latitude"]]];
            [xmlWrite writeAttribute:@"lon" value:[NSString stringWithFormat:@"%@", [[resultArray objectAtIndex:i] valueForKey:@"longitude"]]];
        
            [xmlWrite writeStartElement:@"time"];
                [xmlWrite writeCharacters:[NSString stringWithFormat:@"%@", gregorian]];
            [xmlWrite writeEndElement];
        
            [xmlWrite writeStartElement:@"name"];
                [xmlWrite writeCharacters:[NSString stringWithFormat:@"%i", i]];
            [xmlWrite writeEndElement];
        
        [xmlWrite writeEndElement];
    }

    
            [xmlWrite writeEndElement]; // End trkseg
        [xmlWrite writeEndElement]; // End trk
    [xmlWrite writeEndDocument]; // End gpx
    
    NSString * gpx = [xmlWrite toString];
    return gpx;
    
}

@end
