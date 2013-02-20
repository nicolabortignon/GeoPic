//
//  HistoryControllerViewController.m
//  PicsTagger
//
//  Created by Alberto Baggio on 17/02/13.
//  Copyright (c) 2013 cappuccino at work. All rights reserved.
//

#import "HistoryControllerViewController.h"

@interface HistoryControllerViewController ()

@end

@implementation HistoryControllerViewController

@synthesize table;
@synthesize backButton;

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
    //selectedRow = -1;
    trackList = [[DataWrapper sharedWrapper] trackList];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy, HH:mm"];
    [self.view setBackgroundColor:[UIColor greenColor]];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"history_568.png"]]];
    }
    else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"history.jpg"]]];
    }
    table = [[UITableView alloc] initWithFrame:CGRectMake(1, 82, screenBounds.size.width-2, screenBounds.size.height-110) style:UITableViewStylePlain];
    [table setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_back.png"]]];
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [table setDataSource:self];
    [table setDelegate:self];
    [self.view addSubview:table];
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 25, 34, 35)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

}

- (void)closeHistory {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [trackList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSString *track_time = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[[trackList objectAtIndex:indexPath.row] valueForKey:@"timestamp"] intValue]]];
        UIView *color = nil;
        
        color = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 68)];
        
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, 200, 30)];
        [name setText:[[trackList objectAtIndex:indexPath.row] valueForKey:@"name"]];
        [name setBackgroundColor:[UIColor clearColor]];
        [name setTextColor:[UIColor colorWithRed:95.0f/255.0f green:96.00f/255.00f blue:99.0f/255.00f alpha:0.5]];
        name.font = [UIFont boldSystemFontOfSize:18];
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(16, 34, 200, 30)];
        [time setText:track_time];
        [time setBackgroundColor:[UIColor clearColor]];
        time.font = [UIFont systemFontOfSize:16];
        [time setTextColor:[UIColor colorWithRed:95.0f/255.0f green:96.00f/255.00f blue:99.0f/255.00f alpha:0.5]];
        [color addSubview:time];
        UIView *status_button = [[UIView alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 40, 32, 13, 13)];
        [status_button setBackgroundColor:[UIColor clearColor]];
        if ([[[trackList objectAtIndex:indexPath.row] valueForKey:@"sent"] boolValue]) {
            [status_button setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tick.png"]]];
        }
        else {
            [status_button setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cross.png"]]];
        }
        [color addSubview:status_button];
        [color addSubview:name];
        [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 55)];
        [color setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Detail_History.png"]]];
        [cell addSubview:color];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[[TrackDetail alloc] initWithTrack:[[trackList objectAtIndex:indexPath.row] valueForKey:@"timestamp"]] animated:YES];
}



@end
