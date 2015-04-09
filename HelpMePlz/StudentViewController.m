//
//  StudentViewController.m
//  HelpMePlz
//
//  Created by Shahin on 2015-04-07.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "StudentViewController.h"

@interface StudentViewController ()

@end

@implementation StudentViewController

- (IBAction)requestHelp:(UIButton *)sender {
    NSString *name = [PFUser currentUser][@"Name"];
    NSString *notes = @"add notes here";
    NSTimeInterval helpDuration;
    BOOL isHandled;
    
    PFObject *request = [PFObject objectWithClassName:@"Requests"];
    [request setObject:name forKey:@"name"];
    [request setObject:notes forKey:@"notes"];
    [request setObject:[[PFUser currentUser] objectId] forKey:@"senderId"];
    [request setObject:[[PFUser currentUser] username] forKey:@"senderName"];
    [request saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An error occurred!"
                                                                message:@"Please try sending your message again."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        else {
            // Everything was successful!
            NSLog(@"Request saved successfully, yay!");
        }
    }];

    
    PFPush *push = [[PFPush alloc] init];
    NSString *alert = [NSString stringWithFormat:@"%@ needs your help.", [PFUser currentUser][@"Name"]];
    NSDictionary *data = @{
                           @"alert" : alert,
                           @"badge" : @"Increment",
                           @"sounds" : @"cheering.caf",
                           @"username" : [PFUser currentUser].username
                           };
    NSLog(@"%@", data);
    [push setChannel:@"TA"];
    [push setData:data];
    [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!succeeded)
        {
            NSLog(@"Push error: %@",[error localizedDescription]);
        } else {
            NSLog(@"error: %@", [error userInfo]);
        }
    }];
}

@end
