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
    [self.helpRequestLabel setBackgroundImage:[UIImage imageNamed:@"buttons_Red Button.png"] forState:UIControlStateNormal];
    [self.helpRequestLabel setTitle:@"Request Help" forState:UIControlStateNormal];
    self.helpLabel.hidden = YES;
}

- (IBAction)requestHelp:(UIButton *)sender {
    self.hasChanged =! self.hasChanged;
    if (self.hasChanged) {
        NSString *name = [PFUser currentUser][@"Name"];
        NSString *imageName = [PFUser currentUser][@"image"];
        NSTimeInterval helpDuration = 0;
        BOOL isHandled = NO;
        BOOL issueResolved = NO;
        NSString *notes = @"add notes here";
        
        PFObject *request = [PFObject objectWithClassName:@"Requests"];
        [request setObject:name forKey:@"name"];
        [request setObject:imageName forKey:@"imageName"];
        [request setObject:notes forKey:@"notes"];
        [request setObject:[NSNumber numberWithBool:isHandled] forKey:@"isHandled"];
        [request setObject:[NSNumber numberWithBool:issueResolved] forKey:@"issueResolved"];
        [request setObject:[NSNumber numberWithDouble:helpDuration] forKey:@"helpDuration"];
        
        [request setObject:[[PFUser currentUser] objectId] forKey:@"senderId"];
        [request setObject:[[PFUser currentUser] username] forKey:@"senderName"];
        
        PFACL *requestACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [requestACL setPublicWriteAccess:YES];
        [requestACL setPublicReadAccess:YES];
        request.ACL = requestACL;
        [request saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An error occurred!"
                                                                    message:@"Please try sending your message again."
                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else {
                NSLog(@"Request saved successfully, yay!");
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
        }];        
        [self.helpRequestLabel setBackgroundImage:[UIImage imageNamed:@"buttons_Blue Button.png"] forState:UIControlStateNormal];
        [self.helpRequestLabel setTitle:@"Cancel Help" forState:UIControlStateNormal];
        self.helpLabel.hidden = NO;
    }
    else {
        [self.helpRequestLabel setBackgroundImage:[UIImage imageNamed:@"buttons_Red Button.png"] forState:UIControlStateNormal];
        [self.helpRequestLabel setTitle:@"Request Help" forState:UIControlStateNormal];
        self.helpLabel.hidden = YES;
    }
}

@end
