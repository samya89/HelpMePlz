//
//  AppDelegate.m
//  HelpMePlz
//
//  Created by Samia Al Rahmani on 4/6/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "AppDelegate.h"
#import "HistoryDetailViewController.h"
#import <Parse/Parse.h>
#import <Parse/PFTwitterUtils.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Parse setApplicationId:@"hA5hkShzgSnPP3gjZZx9Vu0DdS5xarIeT8QBLKI9"
                  clientKey:@"TYGLDSmIfxtdAFsGPOmG7VEiaWoBdpUXqhdumg4i"];
    
    [PFTwitterUtils initializeWithConsumerKey:@"LYyqXWNcR1dUvQAWmJSC4zmwK"
                               consumerSecret:@"bdSzENzQgLkgEgUh2xWRsoogfl4355sac526inZXuRuUt3iahu"];
    
    // Set default ACLs
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    PFUser *currentUser = [PFUser currentUser];
    currentInstallation[@"user"] = currentUser ? :[NSNull null];
    [currentInstallation saveInBackground];
    
//    PFInstallation *installation = [PFInstallation currentInstallation];
//    installation[@"user"] = [PFUser currentUser];
//    [installation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

@end
