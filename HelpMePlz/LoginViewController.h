//
//  LoginViewController.h
//  HelpMePlz
//
//  Created by Shahin on 2015-04-06.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/PFLogInViewController.h>

@interface LoginViewController : UIViewController<PFLogInViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

- (IBAction)logOutButtonTapAction:(id)sender;
- (IBAction)backButton:(UIBarButtonItem *)sender;

@end
