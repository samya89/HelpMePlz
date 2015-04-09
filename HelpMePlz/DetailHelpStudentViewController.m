//
//  DetailHelpStudentViewController.m
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/8/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "DetailHelpStudentViewController.h"

@interface DetailHelpStudentViewController ()

@end

@implementation DetailHelpStudentViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_requestItem != newDetailItem) {
        _requestItem = newDetailItem;
        
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.requestItem) {
        
    }
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.studentNameLabel.text = self.requestItem[@"name"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAssisting:(UIButton *)sender{
    
}

- (IBAction)submitAssistDetails:(UIButton *)sender{
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
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
