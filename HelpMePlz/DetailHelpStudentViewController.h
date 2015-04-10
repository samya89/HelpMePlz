//
//  DetailHelpStudentViewController.h
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/8/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class  HelpRequestListTableViewController;

@interface DetailHelpStudentViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startAssistingButton;
@property (weak, nonatomic) IBOutlet UITextView *notesTextview;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *issueResolvedSwitch;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *issueResolvedLabel;

@property (strong, nonatomic) PFObject *requestItem;

- (IBAction)startAssisting:(UIButton *)sender;
- (IBAction)submitAssistDetails:(UIButton *)sender;



@end
