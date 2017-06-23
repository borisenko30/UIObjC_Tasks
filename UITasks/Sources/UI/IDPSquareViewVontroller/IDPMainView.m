//
//  IDPMainView.m
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPMainView.h"

#import "IDPSquareView.h"

static NSString * const IDPStartButtonTitle = @"Start";
static NSString * const IDPStopButtonTitle  = @"Stop";

@interface IDPMainView ()

- (void)toggleButtonName;

@end

@implementation IDPMainView

#pragma mark -
#pragma mark Public

- (void)run {
    IDPSquareView *squareView = self.squareView;
    squareView.running = !squareView.running;
    [self toggleButtonName];
}

#pragma mark -
#pragma mark Private

- (void)toggleButtonName {
    [self.button setTitle:self.squareView.running ? IDPStopButtonTitle : IDPStartButtonTitle
                 forState:UIControlStateNormal];
}

@end
