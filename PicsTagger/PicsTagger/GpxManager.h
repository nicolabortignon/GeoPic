//
//  GpxManager.h
//  PicsTagger
//
//  Created by Alberto Baggio on 17/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLWriter.h"
#import "DataWrapper.h"

@interface GpxManager : NSObject

+ (GpxManager*) sharedManger;
- (NSString*) createGpx:(int)track;


@end
