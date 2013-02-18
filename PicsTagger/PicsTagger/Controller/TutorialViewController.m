//
//  TutorialViewController.m
//  PicsTagger
//
//  Created by Alberto Baggio on 15/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

@synthesize scrollView;
@synthesize pageControl;

const int TUTORIALPAGE = 7;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setDelegate:self];
    [scrollView setScrollEnabled:NO];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(100, 200, 0, 0)];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    [pageControl setFrame:CGRectMake(screenSize.width/2 - pageControl.frame.size.width, screenSize.height - 50, pageControl.frame.size.width, pageControl.frame.size.height)];
    [pageControl setNumberOfPages:TUTORIALPAGE];
    [pageControl setCurrentPage:0];
    [pageControl setBackgroundColor:[UIColor yellowColor]];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.scrollView addGestureRecognizer:panRecognizer];
    
    NSArray *images568 = [NSArray arrayWithObjects:@"Tutorial0_568.jpg",@"Tutorial1_568.jpg",@"Tutorial2_568.jpg",@"Tutorial3_568.jpg",@"Tutorial4_568.jpg",@"Tutorial5_568.jpg",@"Tutorial6_568.jpg", nil];
    NSArray *images = [NSArray arrayWithObjects:@"Tutorial0_568.jpg",@"Tutorial1.jpg",@"Tutorial2.jpg",@"Tutorial3.jpg",@"Tutorial4.jpg",@"Tutorial5.jpg",@"Tutorial6.jpg", nil];
    for (int i = 0; i<TUTORIALPAGE; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        
        // Add exit button
        if ( i==(TUTORIALPAGE-1) ) {
            NSLog(@"init vista 6");
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"btnStart.png"] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(screenSize.width/2 - 50, screenSize.height - 100, 99, 34)];
            [subview addSubview:button];
            [button addTarget:self action:@selector(closeTutorial:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if (screenBounds.size.height == 568) {
            [subview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[images568 objectAtIndex:i]]]];
        } else {
            [subview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[images objectAtIndex:i]]]];
        }
        [self.scrollView addSubview:subview];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * TUTORIALPAGE, self.scrollView.frame.size.height);
    [self.view addSubview:scrollView];
    [self.view addSubview:pageControl];
}

- (void)closeTutorial:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"False" forKey:@"firstAcess"];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:0] animated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer {
    CGPoint velocity = [panRecognizer velocityInView:self.scrollView];
    if(panRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if(velocity.x > 0)
        {
            if( self.pageControl.currentPage > 0) {
                self.pageControl.currentPage -= 1;
                CGRect frame = scrollView.frame;
                frame.origin.x = frame.size.width * pageControl.currentPage;
                frame.origin.y = 0;
                [scrollView scrollRectToVisible:frame animated:YES];
            }
        }
        else
        {
            if( self.pageControl.currentPage < (TUTORIALPAGE-1) ) {
                self.pageControl.currentPage += 1;
                CGRect frame = scrollView.frame;
                frame.origin.x = frame.size.width * pageControl.currentPage;
                frame.origin.y = 0;
                [scrollView scrollRectToVisible:frame animated:YES];
            }
            
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
