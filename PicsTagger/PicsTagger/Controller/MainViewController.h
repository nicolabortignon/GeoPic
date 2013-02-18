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

#import <MessageUI/MessageUI.h>

@interface MainViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    UIButton *startButton;
    UIButton *endButton;
    UIButton *history;
    UIButton *profile;
    Tracker *tracker;
    UITextField *nameTextField;
    LoginController * loginController;
    NSString *last_track;
    bool running;
}

@property (nonatomic,retain) UIButton *startButton;
@property (nonatomic, retain) UIButton *endButton;
@property (nonatomic, retain) UIButton *history;
@property (nonatomic, retain) UITextField *nameTextField;
@property (nonatomic, retain) UIButton *profile;

@end
