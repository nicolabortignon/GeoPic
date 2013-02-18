//
//  MainViewController.m
//  PicsTagger
//
//  Created by Alberto Baggio on 15/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize startButton;
@synthesize endButton;
@synthesize history;
@synthesize nameTextField;
@synthesize profile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    running = FALSE;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainPage_568.jpg"]]];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"SplashOnlyImage.jpg"]]];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstAccess = [defaults objectForKey:@"firstAcess"];
    NSString *loged = [defaults objectForKey:@"loged"];
    NSString *login = [defaults objectForKey:@"login"];
    
    if (loged == NULL) {
        [self.navigationController pushViewController:[[LoginController alloc] init] animated:YES];
    }
    else {
        NSLog(@"%@", loged);
        if ([loged isEqualToString:@"False"]) {
            if(loginController == nil) {
                loginController = [[LoginController alloc] init];
            }
            [self.navigationController pushViewController:loginController animated:YES];
        }
        else {
            if (firstAccess == NULL) {
                [defaults setObject:@"False" forKey:@"firstAcess"];
                [self.navigationController pushViewController:[[TutorialViewController alloc] init] animated:NO];
            }
            else {
                NSLog(@"Already loged %@", login);
            }
        }
    }
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setBackgroundImage:[UIImage imageNamed:@"ButtonOff.png"] forState:UIControlStateNormal];
    
    
    [startButton setFrame:CGRectMake(screenSize.width/2 - 28, screenSize.height - 200, 56, 65)];
    [self.view addSubview:startButton];
    [startButton addTarget:self action:@selector(actionButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    
    history = [UIButton buttonWithType:UIButtonTypeCustom];
    [history setBackgroundImage:[UIImage imageNamed:@"history_button.jpg"] forState:UIControlStateNormal];
    [history setFrame:CGRectMake(0, screenSize.height - 95, 160, 75)];
    [history addTarget:self action:@selector(showHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:history];
    
    
    profile = [UIButton buttonWithType:UIButtonTypeCustom];
    [profile setBackgroundImage:[UIImage imageNamed:@"profile.jpg"] forState:UIControlStateNormal];
    [profile setFrame:CGRectMake(160, screenSize.height - 95, 160, 75)];
    [profile addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:profile];
    
    
}

- (void) actionButtonPushed {
    if(running) {
        running = FALSE;
        [self endTracking];
        [startButton setBackgroundImage:[UIImage imageNamed:@"ButtonOff.png"] forState:UIControlStateNormal];
    }
    else {
        running = TRUE;
        [self startTracking];
        [startButton setBackgroundImage:[UIImage imageNamed:@"ButtonOn.png"] forState:UIControlStateNormal];
    }
}

- (void) logout {
    NSLog(@"logout");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"login"];
    [defaults setObject:@"False" forKey:@"loged"];
    if(loginController == nil) {
        loginController = [[LoginController alloc] init];
    }
    [self.navigationController pushViewController:loginController animated:YES];

}

- (void) showHistory {
    [self.navigationController pushViewController:[[HistoryControllerViewController alloc] init] animated:YES];
}

- (void) startTracking {
    [[Tracker sharedTracker] startTracking];
}

- (void) endTracking {
    last_track = [[Tracker sharedTracker] endTracking];
    
    nameTextField = [[UITextField alloc] init];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Set a Name", @"track_set_name")
                                                          message:@"name" delegate:self cancelButtonTitle:@"Save" otherButtonTitles:nil];
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [nameTextField setBackgroundColor:[UIColor whiteColor]];
    [myAlertView addSubview:nameTextField];
    [myAlertView show];
    
    /*
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Gpx testing"];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"baggio.alberto87@gmail.com", @"andrea.cervellin@gmail.com", nil];
        [mailer setToRecipients:toRecipients];
        [mailer addAttachmentData:data mimeType:@"application/xml" fileName:@"track.gpx"];
        NSString *emailBody = @"Speremo ben";
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    } */
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[DataWrapper sharedWrapper] updateNameTracks:[nameTextField text] track:last_track];
    NSLog(@"%@", [nameTextField text]);
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
