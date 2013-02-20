//
//  HistoryControllerViewController.h
//  PicsTagger
//
//  Created by Alberto Baggio on 17/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataWrapper.h"

@interface HistoryControllerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *table;
    UIButton *backButton;
    NSArray *trackList;
    NSDateFormatter *dateFormatter;
    //int selectedRow;
}

@property (nonatomic, retain) UITableView* table;
@property (nonatomic, retain) UIButton *backButton;

@end
