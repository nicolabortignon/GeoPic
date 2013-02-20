//
//  TrackDetail.h
//  PicsTagger
//
//  Created by Alberto Baggio on 20/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackDetail : UIViewController {
    
    NSString *trackDetail;
    UIButton *backButton;
    
}

@property (nonatomic, retain) UIButton *backButton;

- (id)initWithTrack:(NSString*)track;

@end
