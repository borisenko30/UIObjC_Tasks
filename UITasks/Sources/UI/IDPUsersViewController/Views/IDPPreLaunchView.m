//
//  IDPPreLaunchView.m
//  UITask01
//
//  Created by Student003 on 6/21/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPPreLaunchView.h"

@implementation IDPPreLaunchView

#pragma mark -
#pragma mark Public

- (void)startLoadingAnimation {
    [self.activityIndicator startAnimating];
    NSLog(@"start animation");
}

- (void)stopLoadingAnimation {
    [self.activityIndicator stopAnimating];
    NSLog(@"stop animation");
}

@end
