//
//  StudentViewController.h
//  HelpMePlz
//
//  Created by Shahin on 2015-04-07.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/PFLogInViewController.h>
#import <Parse/PFProduct.h>
#import <Parse/PFInstallation.h>

@interface StudentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *helpRequestLabel;
@property (strong, nonatomic) NSArray *onlineTAs;

- (IBAction)requestHelp:(UIButton *)sender;

@end
