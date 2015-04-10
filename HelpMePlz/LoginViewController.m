//
//  LoginViewController.m
//  HelpMePlz
//
//  Created by Shahin on 2015-04-06.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <Parse/PFTwitterUtils.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <ParseUI/ParseUI.h>


@interface LoginViewController ()

@property (strong, nonatomic) NSMutableArray *allUsers;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([PFUser currentUser]) {        
        if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
            self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"Welcome\n@%@!", nil), [PFTwitterUtils twitter].screenName];
            
        } else {
            self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"Welcome\n%@!", nil), [PFUser currentUser].username];
        }
        
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self createLoginScreen];
}

- (void)createLoginScreen {
    if (![PFUser currentUser]) {
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        logInViewController.delegate = self;
        logInViewController.fields = PFLogInFieldsTwitter | PFLogInFieldsDismissButton;
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

#pragma mark - PFLogInViewControllerDelegate

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    if (user) {
        if ([user[@"TA"] boolValue]){
            NSLog(@"TA");
            PFInstallation *currentInstallation = [PFInstallation currentInstallation];
            [currentInstallation addUniqueObject:@"TA" forKey:@"channels"];
            [currentInstallation saveInBackground];
            [self performSegueWithIdentifier:@"TASegue" sender:self];
        }
        else {
            NSLog(@"student");
            PFInstallation *currentInstallation = [PFInstallation currentInstallation];
            [currentInstallation addUniqueObject:@"Student" forKey:@"channels"];
            [currentInstallation saveInBackground];
            [self performSegueWithIdentifier:@"StudentSegue" sender:self];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}


#pragma mark - ()

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    [self createLoginScreen];
}

- (IBAction)backButton:(UIBarButtonItem *)sender {
    PFUser *user = [PFUser currentUser];
    if ([user[@"TA"] boolValue]){
        [self performSegueWithIdentifier:@"TASegue" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"StudentSegue" sender:self];
    }

}

@end
