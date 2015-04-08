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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)requestHelp:(UIButton *)sender {
//    PFQuery *taQuery = [PFUser query];
//    [taQuery whereKey:@"TA" equalTo:[NSNumber numberWithBool:YES]];
//    [onlineQuery whereKey:@"user" notEqualTo:[NSNull null]];
    PFQuery *taQuery = [PFQuery queryWithClassName:@"_User"];
    [taQuery whereKey:@"TA" equalTo:[NSNumber numberWithBool:YES]];
    PFQuery *onlineQuery = [PFQuery queryWithClassName:@"_Session"];
    [onlineQuery whereKey:@"user" matchesQuery:taQuery];
    [onlineQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            self.onlineTAs = objects;
            NSLog(@"%@", objects);
        }
    }];

}

@end
