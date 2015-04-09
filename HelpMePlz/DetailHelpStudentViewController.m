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


- (IBAction)submitAssistDetails:(UIButton *)sender{
    PFQuery *query = [PFQuery queryWithClassName:@"Requests"];
    
    [query whereKey:@"notes" equalTo:notes];
    [query whereKey:@"isHandled" equalTo:id];
     
     //[query whereKey:@"signupemail" equalTo:myemailaddress];


    
//    NSTimeInterval helpDuration = 0;
    //    [request setObject:[NSNumber numberWithDouble:helpDuration] forKey:@"helpDuration"];
    
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *requestItem, NSError *error) {
        if (!requestItem) {
            NSLog(@"The getFirstObject request failed.");
            
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            requestItem[@"notes"] = self.notesTextview.text;
            requestItem[@"isHandled"] = [NSNumber numberWithBool:YES];
            [requestItem saveInBackground];
        }
    }];
//     [self dismissViewControllerAnimated:YES completion:nil];

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
