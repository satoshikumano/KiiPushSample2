//
//  AppDelegate.m
//  KiiPushSample2
//
//  Created by satoshi on 2016/10/06.
//  Copyright © 2016年 Kii. All rights reserved.
//

#import "AppDelegate.h"
#import <KiiSDK/KiiSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Kii beginWithID:@"9ab34d8b" andKey:@"7a950d78956ed39f3b0815f0f001b43b" andSite:kiiSiteJP];
    [self registerNotification:application];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Device token %@", deviceToken);
    self.token = deviceToken;
}

- (void) registerNotification:(UIApplication*)application {
//    UIMutableUserNotificationAction* action = [[UIMutableUserNotificationAction alloc] init];
//    action.identifier = @"APNS";
//    action.title = @"APNS";
//    action.activationMode = UIUserNotificationActivationModeForeground;
//    [action setAuthenticationRequired:NO];
//    [action setDestructive:YES];
//
//    UIMutableUserNotificationCategory* category = [[UIMutableUserNotificationCategory alloc] init];
//    category.identifier = @"CATEGORY";
//    [category setActions:@[action] forContext:UIUserNotificationActionContextMinimal];
//    [category setActions:@[action] forContext:UIUserNotificationActionContextDefault];
//
//    NSMutableSet* categories = [[NSMutableSet alloc] init];
//    [categories addObject:category];
    UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [application registerForRemoteNotifications];
    [application registerUserNotificationSettings:settings];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"Notification received %@", userInfo);
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
