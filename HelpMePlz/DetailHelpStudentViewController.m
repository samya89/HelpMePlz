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

//BOOL issueResolved = YES;
//    [request setObject:[NSNumber numberWithBool:issueResolved] forKey:@"issueResolved"];


- (IBAction)submitAssistDetails:(UIButton *)sender{
    NSString *notes = self.notesTextview.text;
//    NSTimeInterval helpDuration = 0;
    BOOL isHandled = YES;
    
    self.requestItem = [PFObject objectWithClassName:@"Requests"];
    [self.requestItem setObject:notes forKey:@"notes"];
    
    [self.requestItem setObject:[NSNumber numberWithBool:isHandled] forKey:@"isHandled"];
//    [request setObject:[NSNumber numberWithDouble:helpDuration] forKey:@"helpDuration"];
    
    [self.requestItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
