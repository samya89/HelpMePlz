//
//  DetailHelpStudentViewController.h
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/8/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DetailHelpStudentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *startAssistingButton;
@property (weak, nonatomic) IBOutlet UITextField *notesTextfield;
@property (strong, nonatomic) PFObject *requestItem;

- (IBAction)startAssisting:(UIButton *)sender;

- (IBAction)submitAssistDetails:(UIButton *)sender;



@end
