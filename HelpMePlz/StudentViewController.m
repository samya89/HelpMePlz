//
//  StudentViewController.m
//  HelpMePlz
//
//  Created by Shahin on 2015-04-07.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "StudentViewController.h"

@interface StudentViewController ()

@property (assign, nonatomic) bool hasChanged;

@end

@implementation StudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasChanged = NO;
}

- (IBAction)requestHelp:(UIButton *)sender {
    self.hasChanged =! self.hasChanged;
    if (self.hasChanged) {
        NSString *name = [PFUser currentUser][@"Name"];
        NSString *imageName = [PFUser currentUser][@"image"];
        NSTimeInterval helpDuration = 0;
        BOOL isHandled = NO;
        BOOL issueResolved = NO;
        
        PFObject *request = [PFObject objectWithClassName:@"Requests"];
        [request setObject:name forKey:@"name"];
        [request setObject:imageName forKey:@"imageName"];
        
        [request setObject:[NSNumber numberWithBool:isHandled] forKey:@"isHandled"];
        [request setObject:[NSNumber numberWithBool:issueResolved] forKey:@"issueResolved"];
        [request setObject:[NSNumber numberWithDouble:helpDuration] forKey:@"helpDuration"];
        
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
        [self.helpRequestLabel setImage:[UIImage imageNamed:@"buttons-01.png"] forState:UIControlStateNormal];
    }
    else {
        [self.helpRequestLabel setImage:[UIImage imageNamed:@"buttons-02.png"] forState:UIControlStateNormal];
    }
}

@end
