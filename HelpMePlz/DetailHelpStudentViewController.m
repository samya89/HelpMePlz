//
//  DetailHelpStudentViewController.m
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/8/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "DetailHelpStudentViewController.h"

@interface DetailHelpStudentViewController ()

@property (assign, nonatomic) BOOL issueResolved;

@end

@implementation DetailHelpStudentViewController

#pragma mark - Managing the detail item

- (void)setRequestItem:(id)newDetailItem {
    if (_requestItem != newDetailItem) {
        _requestItem = newDetailItem;
        
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.requestItem) {
        self.studentNameLabel.text = self.requestItem[@"name"]; 
    }
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAssisting:(UIButton *)sender{
}

//BOOL issueResolved = YES;
//    [request setObject:[NSNumber numberWithBool:issueResolved] forKey:@"issueResolved"];

- (IBAction)issueResolvedSwitch:(UISwitch *)sender {
    if ([sender isOn]) {
        self.issueResolved = YES;
    }
    else {
        self.issueResolved = NO;
    }

}

- (IBAction)submitAssistDetails:(UIButton *)sender{
    
    NSString *name = [PFUser currentUser][@"Name"];
    NSString *notes = @"add notes here";
    NSTimeInterval helpDuration = 0;
    
    PFObject *archive = [PFObject objectWithClassName:@"Archives"];
    [archive setObject:name forKey:@"name"];
    [archive setObject:notes forKey:@"notes"];
    
    [archive setObject:[NSNumber numberWithBool:self.issueResolved] forKey:@"issueResolved"];
    [archive setObject:[NSNumber numberWithDouble:helpDuration] forKey:@"helpDuration"];
    
    [archive setObject:[[PFUser currentUser] objectId] forKey:@"senderId"];
    [archive setObject:[[PFUser currentUser] username] forKey:@"senderName"];
    [archive saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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

    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Requests"];
    
    [query whereKey:@"notes" equalTo:@"add notes here"];
    [query whereKey:@"isHandled" equalTo:[NSNumber numberWithBool:NO]];
    
    //    [query whereKey:@"TA" equalTo:[NSNumber numberWithBool:NO]];
     
     //[query whereKey:@"signupemail" equalTo:myemailaddress];
    
//    NSTimeInterval helpDuration = 0;
    //    [request setObject:[NSNumber numberWithDouble:helpDuration] forKey:@"helpDuration"];
    
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *requestItem, NSError *error) {
            requestItem[@"notes"] = self.notesTextview.text;
            requestItem[@"isHandled"] = [NSNumber numberWithBool:YES];
            [requestItem saveInBackground];
    }];
    //     [self dismissViewControllerAnimated:YES completion:nil];
     */
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
