//
//  IDPPreLaunchUsersView.m
//  UITask01
//
//  Created by Student003 on 6/21/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPPreLaunchUsersView.h"

@implementation IDPPreLaunchUsersView

#pragma mark -
#pragma mark Public

- (void)modelDidBeginLoading {
    [self.activityIndicator startAnimating];
    NSLog(@"start animation");
}

- (void)modelDidLoad {
    [self.activityIndicator stopAnimating];
    NSLog(@"stop animation");
}

@end
