//
//  IDPAppDelegate.m
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPAppDelegate.h"

#import "IDPSquareViewController.h"
#import "IDPUsersViewController.h"
#import "IDPUser.h"

@interface IDPAppDelegate ()

@end

@implementation IDPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;

    // Task 01
    //IDPSquareViewController *viewController = [IDPSquareViewController new];
    
    // Task 02
    IDPUsersViewController *viewController = [IDPUsersViewController new];
    viewController.user = [IDPUser new];
    
    window.rootViewController = viewController;
    
    [window makeKeyAndVisible];
    
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

@end
