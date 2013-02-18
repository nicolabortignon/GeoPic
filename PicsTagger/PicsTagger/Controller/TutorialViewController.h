//
//  TutorialViewController.h
//  PicsTagger
//
//  Created by Alberto Baggio on 15/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UIPageControl *pageControl;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;


@end
