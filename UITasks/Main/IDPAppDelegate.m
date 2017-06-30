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

#import "IDPUsersModel.h"

#import "UIWindow+IDPExtensions.h"
#import "UIViewController+IDPExtensions.h"

@interface IDPAppDelegate ()
@property (nonatomic, strong) IDPUsersViewController *controller;

@end

@implementation IDPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;

    // Task 01
//    IDPSquareViewController *viewController = [IDPSquareViewController defaultViewController];
    
    // Task 02
    IDPUsersViewController *viewController = [IDPUsersViewController defaultViewController];
    
    // Task03
    // Task04
        
    window.rootViewController = viewController;
    self.controller = viewController;
    viewController.usersModel = [IDPUsersModel new];

    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.controller saveModel];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.controller saveModel];
}

@end
