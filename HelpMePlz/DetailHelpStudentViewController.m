//
//  DetailHelpStudentViewController.m
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/8/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "DetailHelpStudentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailHelpStudentViewController ()

@property (assign, nonatomic) BOOL issueResolved;
@property (assign, nonatomic) bool hasChanged;

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
    if (self.requestItem) {
        self.studentNameLabel.text = self.requestItem[@"name"]; 
    }
 }

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    
    self.notesTextview.hidden = YES;
    self.issueResolvedSwitch.hidden = YES;
    self.submitButton.hidden = YES;
    self.issueResolvedLabel.hidden = YES;
    
    self.notesTextview.clipsToBounds = YES;
    self.notesTextview.layer.cornerRadius = 10.0f;
    
    self.hasChanged = NO;
    self.notesTextview.delegate = self;
}

- (IBAction)startAssisting:(UIButton *)sender{
    self.hasChanged =! self.hasChanged;
    if (self.hasChanged) {
        [self.startAssistingButton setImage:[UIImage imageNamed:@"buttons-04.png"] forState:UIControlStateNormal];
    }
    else {
        self.notesTextview.hidden = NO;
        self.issueResolvedSwitch.hidden = NO;
        self.issueResolvedLabel.hidden = NO;
        self.startAssistingButton.hidden = YES;
        self.submitButton.hidden = NO;
    }
}

- (IBAction)issueResolvedSwitch:(UISwitch *)sender {
    if ([sender isOn]) {
        self.issueResolved = YES;
    }
    else {
        self.issueResolved = NO;
    }
}

- (IBAction)submitAssistDetails:(UIButton *)sender{
    
    NSString *notes = self.notesTextview.text;
//    NSTimeInterval helpDuration = 0;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Requests"];
    [query getObjectInBackgroundWithId:self.requestItem[@"objectId"] block:^(PFObject *request, NSError *error) {
//        request = [PFObject objectWithClassName:@"Requests"];
        self.requestItem[@"notes"] = notes;
        self.requestItem[@"isHandled"] = [NSNumber numberWithBool:YES];
        self.requestItem[@"issueResolved"] = [NSNumber numberWithBool:self.issueResolved];
        self.requestItem[@"name"] = self.requestItem[@"name"];
        self.requestItem[@"imageName"] = self.requestItem[@"imageName"];
        [self.requestItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.notesTextview setText:@""];
}

@end
