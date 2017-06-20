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

#import "UIWindow+IDPExtensions.h"
#import "UIViewController+IDPExtensions.h"

@interface IDPAppDelegate ()

@end

@implementation IDPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow screenSizeWindow];
    self.window = window;

    // Task 01
//    IDPSquareViewController *viewController = [IDPSquareViewController defaultViewController];
    
    // Task 02
    IDPUsersViewController *viewController = [IDPUsersViewController defaultViewController];
    viewController.user = [IDPUser new];
    
    // Task03
    // Task04
    // Task05
    // Task06
    // Task07
        
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
